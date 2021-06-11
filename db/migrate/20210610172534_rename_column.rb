class RenameColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :items, :count, :quantity
  end
end
