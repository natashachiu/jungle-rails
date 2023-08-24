class Admin::DashboardController < ApplicationController
  def show
    @product_count = Product.count
    @category_count = Category.count
  end
end
# Display a count of how many products are in the database
# Display a count of how many categories are in the database