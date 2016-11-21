class CreateApprovedHomes < ActiveRecord::Migration[5.0]
  def change
    create_table :homes do |t|
      t.string :condo_name
      t.string :va_condo_id
      t.string :detail_uri
      t.string :address
      t.string :status
      t.date   :last_update
      t.date   :request_received_date
      t.date   :request_completion_date
      t.timestamps
    end
    add_index(:homes, :va_condo_id, unique: true)
    add_index(:homes, :detail_uri,  unique: true)
  end
end
