class AddCategoryToProducts < ActiveRecord::Migration[8.0]
  def change
    add_reference :products, :category, foreign_key: true
  end
end
