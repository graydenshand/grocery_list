class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :note
      t.boolean :active
      t.integer :count

      t.timestamps
    end
  end
end
