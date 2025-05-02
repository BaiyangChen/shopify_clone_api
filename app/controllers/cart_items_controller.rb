class CartItemsController < ApplicationController
    before_action :authorize #这是继承application controller的控制器
    def index
        cart_items = current_user.cart_items.includes(:product) #把用户的购物车的每个项的商品的信息放到cart_items 
        render json: cart_items.as_json(include: :product) #把上面的cart_items 转成Json格式发给前端
      end
    
      def create
        cart_item = current_user.cart_items.new(cart_item_params)
        if cart_item.save #保存到数据看，如果已经存在就else
          render json: cart_item, status: :created
        else
          render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        cart_item = current_user.cart_items.find(params[:id])#用前端传来的params[:id]找到购物车的商品项，并且传给cart_item
        if cart_item.update(cart_item_params) #cart_item_params是下面写的，处理前端传来的内容，update是rails所有的模型都有的方法
          render json: cart_item
        else
          render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      def destroy
        cart_item = current_user.cart_items.find(params[:id])
        cart_item.destroy
        head :no_content
      end
    
      private
    
      def cart_item_params
        params.require(:cart_item).permit(:product_id, :quantity) #param是前端传来的数据，要求必须是一个名叫cart_item的对象，包含product id和quantity
      end
end
