class ApplicationController < ActionController::Base
  helper_method :current_cart
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :address, :province_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :address, :province_id])
  end

  private

  def current_cart
    session[:cart] ||= []
  end
end
