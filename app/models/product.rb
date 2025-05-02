class Product < ApplicationRecord
    belongs_to :category
    has_many :order_items
    validates :category_id, presence: true
end
