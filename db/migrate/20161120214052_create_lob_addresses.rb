class CreateLobAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :lob_addresses do |t|
      t.column :lob_data_address_line1, :string
      t.column :lob_data_address_line2, :string
      t.column :lob_data_address_city, :string
      t.column :lob_data_address_state, :string
      t.column :lob_data_address_zip, :string
      t.column :lob_data_address_country, :string
      t.column :lob_data_object, :string
      t.column :lob_data_message, :string
      t.timestamps
    end
    add_reference :approved_homes, :lob_address
  end
end
