class ProductCategoriesController < ApplicationController
  before_action :set_product_category, only: [:show]
  before_action :set_breadcrumbs, only: [:show]
  def show
    @product_category = ProductCategory.find(params[:id])
  end

  private

  def set_product_category
    @product_category = ProductCategory.find(params[:id])
  end

  def set_breadcrumbs
    @breadcrumbs = [
      ['Home', root_path],
      [@product_category.product.name, nil] # Current page has no path.
    ]
  end
end
