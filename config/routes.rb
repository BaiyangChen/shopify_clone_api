Rails.application.routes.draw do
  get "/run_seeds", to: "seed_runner#run"
  resources :products
  post "/signup", to: "auth#signup" #当手动输入，或者点击按钮或者链接的时候，网址变成/signup，会自动在auth后面添加controller，然后找到AuthController（在auth_controller中class名字是AuthController），然后找到signup的方法
  post "/login", to: "auth#login"
  resources :cart_items, only: [:index, :create, :update, :destroy]  #自动生成购物车的3个接口，结尾是/cart_items 但是方法不一样，第一个是get，第二个是post，第三个是delete
  resources :orders, only: [:create, :index, :destroy] #自动生成订单的2个接口，结尾是/orders
  resources :categories, only: [:create, :index, :destroy]
  resources :users, only: [:index, :destroy]
end
