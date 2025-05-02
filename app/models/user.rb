class User < ApplicationRecord
    #has_secure_password 会自动帮你加上密码验证、加密功能
    has_secure_password

    has_many :cart_items, dependent: :destroy
    has_many :orders, dependent: :destroy
    validates :email, presence: true, uniqueness: true
end
