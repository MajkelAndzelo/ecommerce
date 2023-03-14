class OrdersController < ApplicationController
  before_action :require_login
  before_action :set_cart, only: [:new, :create]

  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(order_params)
    @order = current_user.orders.build(order_params)
    @order.name = current_user.nickname
    @order.cart = current_cart
    
    if @order.save
      current_cart.destroy
      session.delete(:cart_id)
      puts "Order created successfully!"
      redirect_to order_path(@order)
    else
      puts "Failed to create order!"
      puts @order.errors.full_messages.inspect
      render :new
    end
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  private
  def set_cart
    @cart = current_user.cart
  end
  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end
end
