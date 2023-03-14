class User < ApplicationRecord
    validates :nickname, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    has_secure_password
    has_many :products
    has_one :cart, dependent: :destroy
    has_many :orders, dependent: :destroy
    def full_name
        "#{name} #{lastname}"
    end
end