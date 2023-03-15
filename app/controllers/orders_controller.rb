class OrdersController < ApplicationController
  before_action :require_login
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show]
  before_action :correct_user, only: [:show]

  def new
    @order = Order.new
  end
  
  def create
    @order = current_user.orders.build(order_params)
    @order.cart = current_cart
  
    if @order.save
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
  end
  
  private

  def set_cart
    @cart = current_user.cart
  end

  def set_order
    @order = current_user.orders.find_by(id: params[:id])
    if @order.nil?
      flash[:alert] = "You are not permitted to see other users' orders"
      redirect_to root_path
    end
  end

  
  def order_params
    params.require(:order).permit(:name, :address, :email, :pay_type)
  end

  def correct_user
    unless @order.user == current_user
      flash[:alert] = "You are not permitted to see other users orders"
      redirect_to root_path
    end
  end
end
