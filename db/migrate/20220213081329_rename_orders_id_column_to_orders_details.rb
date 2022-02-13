class RenameOrdersIdColumnToOrdersDetails < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders_details, :orders_id, :order_id
    rename_column :orders_details, :items_id, :item_id
  end
end
