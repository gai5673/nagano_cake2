class Public::CustomersController < ApplicationController
before_action :authenticate_customer!
 def show
  @customer = current_customer
 end

 def edit
  @customer = Customer.find(params[:id])
 end

 def update
  @customer = Customer.find(params[:id])
  if @customer.update(customer_params)
   redirect_to customers_my_page_path(current_customer.id)
  else
   render :edit
  end
 end

 def quit
  @customer = current_customer
 end

 def out
  @customer = Customer.find(params[:id])
  if @customer.update(is_active: false)
  sign_out current_customer
 end
  redirect_to root_path
 end

private
 def customer_params
  params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :email, :password ,:telephone_number, :postal_code, :address, :is_active)
 end

end