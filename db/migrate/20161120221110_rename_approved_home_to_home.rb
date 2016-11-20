class RenameApprovedHomeToHome < ActiveRecord::Migration[5.0]
  def change
    rename_table :approved_homes, :homes
  end
end
