class Product < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :line_items
    has_one_attached :image
    validates :name, presence: true
    validates :price, presence: true
    validates :description, presence: true
    validates :user, presence: true
    validates :category, presence: true
end
  