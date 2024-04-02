class ProductsController < ApplicationController
  before_action :set_product_category, only: [:show]

  def index
    @q = ProductCategory.ransack(params[:q])
    @product_categories = @q.result.includes(:category)

    if params[:new_products] == '1'
      @product_categories = @product_categories.new_categories
    end

    if params[:recently_updated] == '1'
      @product_categories = @product_categories.recently_updated
    end

    @product_categories = @product_categories.page(params[:page]).per(12)
  end

  def show
    # @product_category is set by the before_actionD
  end

  private
  def set_product_category
    @product_category = ProductCategory.find(params[:id])
  end
end
