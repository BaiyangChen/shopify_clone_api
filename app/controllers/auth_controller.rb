class AuthController < ApplicationController
    def signup
        user = User.new(user_params)  #创建一个user的对象，里面的的内容是从下面user_params方法传来的，包含email和password
        if user.save  #  save会把用户保存到数据库，如果成功就往下执行，如果不成功就执行else
          token = encode_token({ user_id: user.id }) #会用下面的encode_token，这个token有一个字段叫user_id，值就是user中的id，然后把user id包进去，
          render json: { user: user, token: token }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def login
        user = User.find_by(email: params[:email])  #在user中找到email为params中的邮箱地址的用户
        if user&.authenticate(params[:password])  #user&就是如果是空的话不报错，而是返回false，authenticate是rails的功能，用来自动验证密码
          token = encode_token({ user_id: user.id }) #用下面的方法，把user id包进去token中
          render json: { user: user, token: token } #以json方式返回，返回的内容是user的数据，和token
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
    end

    private

    def user_params
    params.require(:user).permit(:email, :password) #params是ruby自己的功能，里面装着前端传来的user的数据，但是只获取email和password
    end

    def encode_token(payload)
    JWT.encode(payload, 'your_secret_key') #用jwt生成加密字符串（token），把payload包含在token里，然后盖上your_secret_key的章（用来加密的密钥）-就是以后
    end
end
