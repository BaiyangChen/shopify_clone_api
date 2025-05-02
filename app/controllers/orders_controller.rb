class OrdersController < ApplicationController
    before_action :authorize
    def create
        # 第一步：拿到当前用户购物车里的所有商品
        cart_items = current_user.cart_items.includes(:product)
    
        if cart_items.empty?
          return render json: { message: "shopping cart empty" }, status: :unprocessable_entity
        end
    
        # 第二步：计算总价
        total_price = cart_items.sum do |item| #从cart_items这个数组中遍历每一项，每一项的名字为item，拿出item的价钱*数量的结果，然后求和
          item.product.price * item.quantity
        end
    
        # 第三步：创建订单
        order = current_user.orders.create(total_price: total_price, status: "paid") #在付款之后会创建一个订单，create方法是在user.rb中用了has many，ruby会自动创建几个方法
        
        #把每个购物车商品都保存成 OrderItem
        cart_items.each do |item|
            OrderItem.create(
              order: order,
              product: item.product,
              quantity: item.quantity,
              price: item.product.price
            )
        end

        # 第四步：清空购物车
        cart_items.destroy_all
    
        # 第五步：返回支付成功信息
        render json: { message: "payment success!", order: order }, status: :created
    end

    def destroy
        order = current_user.orders.find(params[:id])
        order.destroy
        head :no_content
    end
    
    def index
       orders = current_user.orders.includes(order_items: :product) #把用户的订单，包含每一个订单项和这个订单项的商品
       render json: orders.as_json(include: { order_items: { include: :product } })
    end
end
