require 'csv'

def home_and_lob_from_hash input_hash
   transformed_home = HashWithIndifferentAccess.new({
     :condo_name => input_hash["Condo Name (ID)"],
     :address => input_hash["Address"],
     :status => input_hash["Status"],
     :va_condo_id => input_hash["id"],
     :detail_uri => input_hash["detail_uri"]
   })

  [
    [:last_update, input_hash["Last Update"]], 
    [:request_received_date, input_hash["Request Received Date"]], 
    [:request_completion_date, input_hash["Request Completion Date"]], 
  ].each do |key, value|
    begin
      transformed_home[key] = value.to_date
    rescue
      transformed_home[key] = nil
    end
  end

  transformed_lob = HashWithIndifferentAccess.new([
    'lob_data_address_line1', 
    'lob_data_address_line2', 
    'lob_data_address_city', 
    'lob_data_address_state', 
    'lob_data_address_zip', 
    'lob_data_address_country', 
    'lob_data_object', 
    'lob_data_message'
  ].map {|old_key|
    [old_key.gsub(/^lob_data_/, ''), input_hash[old_key]]
  }.to_h)

  [
    transformed_home,
    transformed_lob.values.all?(&:nil?) ? nil : transformed_lob
  ]
end

def debug_output(data, current_home, filename)
  duplicate_rows = data.select { |h, l|
    h['va_condo_id'] == current_home['va_condo_id'] ||
      h['detail_uri'] == current_home['detail_uri']
  }
  csv_indices = duplicate_rows.map {|i| data.index(i)+2}

  out = []
  out << "#{filename} contains multiple entries with either".red
  out << "the same id or detail_uri. This is unacceptable.".red
  out << ""
  out << "Nothing has been saved.".red.bold
  out << ""
  out << "Duplicate rows: #{csv_indices.join(', ')}".yellow.bold
  duplicate_rows.each do |h|
    out << ""
    out << h[0].to_h.to_yaml.colorize(:yellow)
  end
  out.join("\n")
end

task import_csvs_in_input: [:environment] do
  Home.destroy_all
  input_path = File.join(Rails.root, 'input')
  filenames = Dir.entries(input_path).select {|f| f =~ /\.csv$/}
  filenames.map! {|f| File.join(input_path, f) }
  Home.transaction {
    filenames.each do |filename|
      matrix = CSV.read(filename)
      headers = matrix[0]
      data = matrix[1..-1].map do |row|
        home_and_lob_from_hash(headers.zip(row).to_h)
      end
        data.each_with_index do |d, index|
          home, lob = d
          begin
            home = Home.create(home)
            LobAddress.create(lob.update(home: home)) unless lob.nil?
          rescue ActiveRecord::RecordNotUnique => e
            print debug_output(data, home, filename)
            raise ActiveRecord::Rollback
          end
        end
      end
  }
end
