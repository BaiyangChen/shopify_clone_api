class ProductsController < ApplicationController
  before_action :admin_only, only: [:create, :update, :destroy]
    def index
        products = Product.all
        render json: products
    end
    def show
        product = Product.find(params[:id])
        render json: product
    end
    def create
        product = Product.new(product_params)
        if product.save
          render json: product, status: :created
        else
          render json: product.errors, status: :unprocessable_entity
        end
    end
    def update
        product = Product.find(params[:id])
        if product.update(product_params)
          render json: product
        else
          render json: product.errors, status: :unprocessable_entity
        end
    end
    def destroy
        product = Product.find(params[:id])
        unless product
          render json: { error: "Product not exist" }, status: :not_found and return
        end
      
        if product.order_items.any?
          render json: { error: "Product has been save to an order, deleting not allow" }, status: :unprocessable_entity and return
        end
      
        product.destroy
        head :no_content
    end

    private
    def product_params
    params.require(:product).permit(:name, :description, :price, :image_url, :category_id)
    end
end
