class Cart < ApplicationRecord
    belongs_to :user
    has_many :line_items, dependent: :destroy
    has_one :order, dependent: :destroy
    def add_product(product)
      current_item = line_items.find_by(product_id: product.id)
  
      if current_item
        current_item.quantity += 1
      else
        current_item = line_items.build(product_id: product.id)
      end
  
      current_item
    end
  
    def total_price
      line_items.to_a.sum { |item| item.total_price }
    end
  
    def update_cart(product_id, quantity)
      current_item = line_items.find_by(product_id: product_id)
  
      if quantity.to_i > 0
        current_item.update(quantity: quantity)
      else
        current_item.destroy
      end
    end
end
  