
class ProductsController < ApplicationController
  before_action :set_product_category, only: [:show]

  def index
    @q = ProductCategory.ransack(params[:q])
    @product_categories = @q.result.includes(:category)

     # Apply the search filter if a keyword is present
     if params[:keyword].present?
      @product_categories = @product_categories.joins(:product).where('products.name LIKE :keyword OR product_categories.description LIKE :keyword', keyword: "%#{params[:keyword]}%")
    end

    # Apply the category filter if a category is selected
    if params[:category_id].present? && params[:category_id] != 'none'
      @product_categories = @product_categories.where(category_id: params[:category_id])
    end

    if params[:on_sale] == '1'
      @product_categories = @product_categories.on_sale
    end

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
