# app/models/cart.rb
class Cart
  attr_reader :items

  def initialize(session_cart)
    @items = session_cart || []
  end

  def add_product(product_id, quantity)
    current_item = @items.find { |item| item[:product_id] == product_id }
    if current_item
      current_item[:quantity] += quantity
    else
      @items << { product_id: product_id, quantity: quantity }
    end
  end

  def total_price
    @items.sum do |item|
      product = Product.find(item[:product_id])
      product.price * item[:quantity]
    end
  end
end
