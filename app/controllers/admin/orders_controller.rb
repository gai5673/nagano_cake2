class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

 def top
  @orders = Order.page(params[:page]).per(10)
 end

 def show
  @order = Order.find(params[:id])
  @orders_details = @order.orders_details.all
  @total_price = calculate(current_customer)
 end


private
def calculate(customer)
  total_price = 0
  customer.cart_items.each do |cart_item|
  total_price += cart_item.amount * cart_item.item.price
 end
  return (total_price * 1.1).floor
 end
end