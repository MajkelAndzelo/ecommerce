class ProductsController < ApplicationController
    before_action :require_login, except: [:index, :show]
    before_action :set_product, only: [:show, :edit, :update, :destroy]
    before_action :require_owner_or_admin, only: [:edit, :update, :destroy]
    before_action :my_products, only: [:my_products]



    def index
      if params[:category_id]
        @category = Category.find(params[:category_id])
        @products = @category.products.paginate(page: params[:page], per_page: 1) 
      else
        @products = Product.all.paginate(page: params[:page], per_page: 1) 
      end
      
    end

    def my_products
      @products = current_user.products
    end
  
    def new
      @product = current_user.products.build
    end
  
    def create
      @product = current_user.products.build(product_params)
      @product.image = params[:product][:image]
      if @product.save
        redirect_to @product, notice: "Product created successfully"
      else
        render :new
      end
    end
  
    def edit
    end
  
    def update
      if @product.update(product_params)
        @product.image = params[:product][:image] if params[:product][:image].present?
        redirect_to @product, notice: "Product updated successfully"
      else
        render :edit
      end
    end
  
    def destroy
      @product.line_items.destroy_all
      @product.destroy
      redirect_to products_path, notice: "Product deleted successfully"
    end
  
    def show
      @line_item = LineItem.new
    end
  
    private
  
    def product_params
      params.require(:product).permit(:name, :description, :price, :image, :category_id, :quantity, :page)
    end
    
   
    
    def set_product
        @product = Product.find(params[:id])
    end
    
    def require_owner_or_admin
        unless current_user.admin? || current_user == @product.user
          redirect_to @product, alert: "You are not authorized to perform this action"
        end
    end
end
    