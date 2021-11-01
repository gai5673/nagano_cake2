class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|

      t.timestamps
      t.integer :genre_id, null: false, default: ""
      t.string :name, null: false, default: ""
      t.string :image_id, null: false, default: ""
      t.text :introduction, null: false, default: ""
      t.integer :price, null: false, default: ""
      t.boolean :is_active
      t.datetime :create_at
      t.datetime :updated_at
    end
  end
end
