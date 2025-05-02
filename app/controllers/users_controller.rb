class UsersController < ApplicationController
    before_action :authorize
    before_action :admin_only

    def index
        users = User.all
        render json: users
    end

    def destroy
        user = User.find(params[:id])
        unless user
            render json: { error: "用户不存在" }, status: :not_found and return
        end
        
        # if user.orders.any?
        #     render json: { error: "该用户有订单，不能删除" }, status: :unprocessable_entity and return
        # end
        user.destroy
        head :no_content
    end
end
