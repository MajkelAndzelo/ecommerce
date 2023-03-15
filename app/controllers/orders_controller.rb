class OrdersController < ApplicationController
  before_action :require_login
  before_action :set_cart, only: [:new, :create]
  before_action :set_user, only: [:new, :create, :show]
  before_action :correct_user, only: [:new, :create, :show]


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


def set_user
  @user = User.find(params[:id])
rescue ActiveRecord::RecordNotFound
  flash[:alert] = "You are not permitted to see other users orders"
  redirect_to root_path
end


def correct_user
  unless @user == current_user
    flash[:alert] = "You are not permitted to see other users orders"
    redirect_to root_path
  end
end