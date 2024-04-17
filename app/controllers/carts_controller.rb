class CartsController < ApplicationController
  def show
    @cart_items = current_cart.map do |item|
      product = Product.find(item["product_id"])
      {
        product: product,
        quantity: item["quantity"],
        subtotal: product.price * item["quantity"]
      }
    end
  end
end
