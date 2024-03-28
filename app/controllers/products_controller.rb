class ProductsController < ApplicationController
  before_action :set_product_category, only: [:show]


  def index
    @product_categories = ProductCategory.page(params[:page]).per(10) # Adjust the number per page as desired
  end

  def show
    # @product_category is set by the before_actionD
  end

  private

  def set_product_category
    @product_category = ProductCategory.find(params[:id])
  end

end
