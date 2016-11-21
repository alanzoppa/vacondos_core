class CreateLobAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :lob_addresses do |t|
      t.column :address_line1, :string
      t.column :address_line2, :string
      t.column :address_city, :string
      t.column :address_state, :string
      t.column :address_zip, :string
      t.column :address_country, :string
      t.column :object, :string
      t.column :message, :string
      t.timestamps
    end
    add_reference :lob_addresses, :home
  end
end
