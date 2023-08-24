class ProductsController < ApplicationController

  def index
    @products = Product.all.order(created_at: :desc)
    # render json: @products
  end

  def show
    @product = Product.find params[:id]
    # render json: @product
  end

end
