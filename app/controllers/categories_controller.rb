class CategoriesController < ApplicationController
    def create
        category = Category.new(category_params)
        if category.save
          render json: category, status: :created
        else
          render json: { errors: category.errors.full_messages }, status: :unprocessable_entity
        end
    end
    
    def index
      categories = Category.all
      render json: categories
    end

    def destroy
      category = Category.find_by(id: params[:id])
      unless category
        render json: { error: '分类不存在' }, status: :not_found and return
      end
  
      if category.products.any?
        render json: { error: '该分类下有商品，不能删除' }, status: :unprocessable_entity and return
      end
  
      category.destroy
      head :no_content
    end
    
    private
    
    def category_params
      params.require(:category).permit(:name)
    end
end
