require 'rails_helper'

RSpec.describe Product, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  before do
    @category = Category.new({name: 'fruit'})
    @category.save
  end

  describe 'Validations' do
    it 'saves successfully given a product with all four categories' do
      @product = Product.new({name: 'fig', category: @category, quantity: 2, price: 1500})
      expect(@product).to be_valid
    end

    it 'should have an error if name is not set' do
      @product = Product.new({name: nil, category: @category, quantity: 2, price: 1500})
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should have an error if category is not set' do
      @product = Product.new({name: 'fig', category: nil, quantity: 2, price: 1500})
      @product.save
      expect(@product.errors.full_messages).to include("Category must exist")
    end

    it 'should have an error if quantity is not set' do
      @product = Product.new({name: 'fig', category: @category, quantity: nil, price: 1500})
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should have an error if price is not set' do
      @product = Product.new({name: 'fig', category: @category, quantity: 2})
      @product.save
      expect(@product.errors.full_messages).to include("Price is not a number")
    end
  end
end
