class DropUnusedColumns < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :active
    remove_column :items, :note
  end
end
