class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

 def top
  @orders = Order.page(params[:page]).per(10)
 end

 def show
  @order = Order.find(params[:id])
  @orders_details = @order.orders_details.all

 end

end