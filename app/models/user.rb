class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    before_save :downcase_email
    has_secure_password


    attr_accessor :old_password, :new_password, :new_password_confirmation
    has_many :products, dependent: :destroy
    has_one :cart, dependent: :destroy
    has_many :orders, dependent: :destroy



    validates :nickname, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
    validates :password, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    
    

    def update_with_password(params)
        if params[:new_password].blank? || params[:new_password_confirmation].blank?
          errors.add(:base, "New password and password confirmation must be present")
          return false
        end
      
        if params[:new_password] == params[:new_password_confirmation]
          update(password: params[:new_password], password_confirmation: params[:new_password_confirmation])
        else
          errors.add(:base, "New password and password confirmation do not match")
          return false
        end
    end


    def full_name
        "#{name} #{lastname}"
    end
    
    private    

    def downcase_email
        self.email = email.downcase
    end
end