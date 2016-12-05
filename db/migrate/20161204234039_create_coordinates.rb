class CreateCoordinates < ActiveRecord::Migration[5.0]
  def change
    create_table :coordinates do |t|
      t.references :home, foreign_key: true
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
