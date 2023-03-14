require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:user) { User.create(first_name: "John", last_name: "Doe", email: "john@example.com", password: "password") }
  let(:category) { Category.create(name: "Test Category") }

  it "is valid with valid attributes" do
    product = Product.new(name: "Test Product", price: 9.99, description: "This is a test product.", user: user, category: category)
    expect(product).to be_valid
  end

  it "is not valid without a name" do
    product = Product.new(price: 9.99, description: "This is a test product.", user: user, category: category)
    expect(product).to_not be_valid
  end

  it "is not valid without a price" do
    product = Product.new(name: "Test Product", description: "This is a test product.", user: user, category: category)
    expect(product).to_not be_valid
  end

  it "is not valid without a description" do
    product = Product.new(name: "Test Product", price: 9.99, user: user, category: category)
    expect(product).to_not be_valid
  end

  it "is not valid without a user" do
    product = Product.new(name: "Test Product", price: 9.99, description: "This is a test product.", category: category)
    expect(product).to_not be_valid
  end

  it "is not valid without a category" do
    product = Product.new(name: "Test Product", price: 9.99, description: "This is a test product.", user: user)
    expect(product).to_not be_valid
  end
end
