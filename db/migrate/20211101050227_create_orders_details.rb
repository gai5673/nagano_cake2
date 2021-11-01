class CreateOrdersDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :orders_details do |t|

      t.timestamps
      t.integer :items_id, null: false, default: ""
      t.integer :orders_id, null: false, default: ""
      t.integer :price, null: false, default: ""
      t.integer :quantity, null: false, default: ""
      t.integer :production_status
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
