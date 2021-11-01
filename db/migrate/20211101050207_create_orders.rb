class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|

      t.timestamps
      t.integer :customer_id, null: false, default: ""
      t.string :postal_code, null: false, default: ""
      t.string :address, null: false, default: ""
      t.string :name, null: false, default: ""
      t.integer :postage, null: false, default: ""
      t.integer :amount_claimed, null: false, default: ""
      t.integer :payment, null: false, default: 0
      t.integer :status
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
