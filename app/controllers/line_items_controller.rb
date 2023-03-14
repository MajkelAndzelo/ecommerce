class LineItemsController < ApplicationController
  def create
    @cart = current_cart
    @product = Product.find(params[:line_item][:product_id]) # get the product ID from the params
    @line_item = @cart.line_items.build(product: @product, quantity: params[:line_item][:quantity])
    if @line_item.save
      redirect_to cart_path(@cart), notice: "Product added to cart"
    else
      render :new
    end
  end
  
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy
    redirect_to cart_path(current_cart), notice: "Product removed from cart"
  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity, :product_id)
  end
end
