class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|

      t.timestamps
      t.integer :customer_id
      t.string :name, null: false, default: ""
      t.string :postal_code, null: false, default: ""
      t.string :address, null: false, default: ""
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
