# frozen_string_literal: true

class CreateItemListTable < ActiveRecord::Migration[6.1]
  def change
    create_table :item_lists do |t|
      t.string :name, unique: true
      t.timestamps
    end

    change_table :items do |t|
      t.references :item_list
    end

    rename_column :events, :item, :data
  end
end
