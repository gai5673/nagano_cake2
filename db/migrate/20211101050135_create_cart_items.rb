class CreateCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_items do |t|

      t.timestamps
      t.integer :item_id, null: false, default: ""
      t.integer :customer_id, null: false, default: ""
      t.integer :amount, null: false, default: ""
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
