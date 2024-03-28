class ProductsController < ApplicationController
  def index
    # In your controller
@product_categories = ProductCategory.page(params[:page]).per(10) # Adjust the number per page as desired

  end
end
# image_attachment: :blob
