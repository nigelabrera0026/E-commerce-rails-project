class ApplicationController < ActionController::Base
  helper_method :current_cart

  private

  def current_cart
    session[:cart] ||= []
  end
end
