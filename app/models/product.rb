class Product < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :line_items
    has_one_attached :image
end
  