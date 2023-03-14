class Order < ApplicationRecord
  PAYMENT_TYPES = ["Credit card", "Paypal", "Purchase order"]

  belongs_to :user
  belongs_to :cart
  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES
  has_many :line_items, through: :cart, dependent: :destroy

  
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
  
  def total_price
    line_items.to_a.sum(&:total_price)
  end
end
