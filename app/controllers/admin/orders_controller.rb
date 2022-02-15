class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

 def top
  @orders = Order.page(params[:page]).per(10)
 end

 def show
  @order = Order.find(params[:id])
  @orders_details = @order.orders_details.all
  @sum = 0
  @subtotals = @orders_details.map { |orders_details| (orders_details.price * 1.1).floor * orders_details.quantity }
  @sum = @subtotals.sum
 end

end