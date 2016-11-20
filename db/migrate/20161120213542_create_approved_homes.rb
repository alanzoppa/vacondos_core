class CreateApprovedHomes < ActiveRecord::Migration[5.0]
  def change
    create_table :approved_homes do |t|
      t.column :condo_name, :string
      t.column :va_condo_id, :string
      t.column :detail_uri, :string
      t.column :address, :string
      t.column :status, :string
      t.column :last_update, :date
      t.column :request_received_date, :date
      t.column :request_completion_date, :date
      t.timestamps
    end
  end
end
