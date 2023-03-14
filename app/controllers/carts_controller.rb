class CartsController < ApplicationController
    def show
      @cart = current_cart
    end
  
    def add
      product = Product.find(params[:product_id])
      current_cart.add_product(product)
      redirect_to cart_path
    end
  
    def remove
      product = Product.find(params[:product_id])
      current_cart.remove_product(product)
      redirect_to cart_path
    end
    def destroy
        @cart = current_cart
        @cart.destroy
        session[:cart_id] = nil
        redirect_to root_path, notice: "Your cart is now empty"
    end
    def update
        current_item = current_cart.line_items.find_by(product_id: params[:product_id])
        if current_item
          if params[:quantity].to_i > 0
            current_item.update(quantity: params[:quantity])
          else
            current_item.destroy
          end
        end
        redirect_to cart_path
    end
    
    def checkout
      @cart = current_cart
      if @cart.empty?
        flash[:danger] = "Your cart is empty."
        redirect_to cart_path
      else
        @cart.checkout
        flash[:success] = "Thank you for your purchase!"
        redirect_to root_url
      end
    end
end
  