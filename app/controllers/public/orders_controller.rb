class Public::OrdersController < ApplicationController
 before_action :authenticate_customer!

 def new
  @order = Order.new
  @orders = current_customer.orders.all
  @customer = Customer.find(current_customer.id)
 end

 def log
  @order = Order.new(order_params)
# new 画面から渡ってきたデータを @order に入れます
  if params[:order][:selected_address] == "radio1"
# view で定義している address_number が"1"だったときにこの処理を実行します
# form_with で @order で送っているので、order に紐付いた address_number となります。以下同様です
# この辺の紐付けは勉強不足なので gem の pry-byebug を使って確認しながら行いました
    @order.name = current_customer.name # @order の各カラムに必要なものを入れます
    @order.address = current_customer.customer_address
  elsif params[:order][:selected_address] == "radio2"
# view で定義している address_number が"3"だったときにこの処理を実行します
  address_new = current_customer.addresses.new(address_params)
  if address_new.save # 確定前(確認画面)で save してしまうことになりますが、私の知識の限界でした
  else
      render :new
# ここに渡ってくるデータはユーザーで新規追加してもらうので、入力不足の場合は new に戻します
  end
  else
    render :new # ありえないですが、万が一当てはまらないデータが渡ってきた場合の処理です
  end
  @cart_items = current_customer.cart_items.all # カートアイテムの情報をユーザーに確認してもらうために使用します
  @total_price = calculate(current_customer)
# 合計金額を出す処理です sum_price はモデルで定義したメソッドです
 end

 def complete
 end

 def create
  cart_items = current_customer.cart_items.all
  @order = current_customer.orders.new(order_params)
  if @order.save
    cart_items.each do |cart|
    order_details = OrderDetails.new
    order_details.item_id = cart.item_id
    order_details.order_id = @order.id
    order_details.order_quantity = cart.quantity
    order_details.order_price = cart.item.price
# カート情報を削除するので item との紐付けが切れる前に保存します
    order_details.save
    end
    redirect_to orders_log_path
    cart_items.destroy_all
# ユーザーに関連するカートのデータ(購入したデータ)をすべて削除します(カートを空にする)
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
  @order_details = @order.order_details
 end

private
 def order_params
  params.require(:order).permit(:postal_code, :address, :name, :payment)
 end

 def calculate(customer)
  total_price = 0
  customer.cart_items.each do |cart_item|
  total_price += cart_item.amount * cart_item.item.price
  end
  return (total_price * 1.1).floor
  end
 end