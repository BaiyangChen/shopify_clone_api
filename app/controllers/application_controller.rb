class ApplicationController < ActionController::API
    def encode_token(payload) #定义一个方法，这个方法在auth controller登陆或者注册成功里之后，会传回来user id，把这个user id打包并且加密，这一页是所有控制器的父类，这个方法可以在子类重写
        JWT.encode(payload, 'your_secret_key')
    end
    
    def auth_header
        #在前端传来的请求中 当请求需要认证自己是谁的时候，请求头会有authorization这一行，也就是包含token的，这一行就是告诉后端我是谁
        # 读取请求头里的 Authorization，格式：Bearer token
        request.headers['Authorization']
    end
    
    def decoded_token
        if auth_header
          token = auth_header.split(' ')[1] # 把token按空格拆分，那第二个位置的内容，"Bearer token" → 拿第二部分
          begin
            #用 'your_secret_key' 这个密钥，把 token 解密，验证 token的签名 是否正确，解出来后用 HS256 这个算法检查
            JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256') #这里的token就是上面的payload
          rescue JWT::DecodeError
            nil
          end
        end
    end
    
    def current_user
        if decoded_token #调用decoded_token，看看是不是空
          user_id = decoded_token[0]['user_id'] #不是空的话，再次执行decoded_token，拿到decoded_token第一个元素的user id
          @user = User.find_by(id: user_id) #拿着user id去数据库找对应的user，然后返回给@user，@就是这个变量可以整个class共享
        end
    end
    
    def logged_in? #这个方法返回bool值
        !!current_user #检查current_user存不存在，！！把空的变成false，避免爆错
    end
    
    def authorize #在子控制器中，需要登陆才能发送请求的控制器都需要在前面加《before_action :authorize》 这个authorize就是调用这一页父类的方法，判断有没有登陆
        render json: { message: 'please login' }, status: :unauthorized unless logged_in?
    end

    def admin_only
      unless current_user&.admin #current_user是从user库查出来的具体哪个user，然后用&检查是不是空，不是空就看看user里的admin字段是不是true
        render json: { message: "只有管理员能执行这个操作" }, status: :forbidden
      end
    end
end
