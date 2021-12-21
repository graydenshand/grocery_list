# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :action
      t.string :item

      t.timestamps
    end
  end
end
