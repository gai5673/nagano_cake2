class Public::OrdersController < ApplicationController
 before_action :authenticate_customer!

 def new
  @order = Order.new
  @orders = current_customer.orders.all
  @customer = Customer.find(current_customer.id)
 end

 def log
  @order = Order.new(order_params)
session[:payment] = order_params[:payment]
  if params[:order][:selected_address] == "radio1"
   @order.name = current_customer.first_name + current_customer.last_name
   @order.postal_code = current_customer.postal_code
   @order.address = current_customer.address
  elsif params[:order][:selected_address] == "radio2"
   address_new = current_customer.address.new(address_params)
  if address_new.save
   redirect_to orders_log_path
  else
    @customer = current_customer
    render :new
  end
  end

  @total_price = calculate(current_customer)
  @order.postage = 800
  @cart_items = current_customer.cart_items.all
 end

 def complete
 end

 def create
  cart_items = current_customer.cart_items.all
  @order = current_customer.orders.new(order_params)
  @order.postage = 800
  @total_price = calculate(current_customer)
  @order.amount_claimed = @total_price + @order.postage
session[:payment] = order_params[:payment]
  if @order.save

  cart_items.each do |cart_item|
  order_details = OrdersDetail.new
  order_details.item_id = cart_item.item_id
  order_details.order_id = @order.id
  order_details.quantity = cart_item.amount
  order_details.price = cart_item.item.price
  order_details.save
  end
  cart_items.destroy_all
  redirect_to orders_complete_path
  else
  @order = Order.new(order_params)
  render :new
  end
 end

 def index
  @orders = current_customer.orders.all
 end

 def show
  @order = Order.find(params[:id])
  @orders_details = @order.orders_details
  @total_price = calculate(current_customer)
 end

private
 def order_params
  params.require(:order).permit(:postal_code, :address, :name, :payment, :created_at, :updated_at, :customer_id, :amount_claimed)
 end

 def address_params
  params.require(:address).permit(:customer_id, :name, :postal_code, :address)
 end

 def calculate(customer)
  total_price = 0
  customer.cart_items.each do |cart_item|
  total_price += cart_item.amount * cart_item.item.price
 end
  return (total_price * 1.1).floor
 end
end