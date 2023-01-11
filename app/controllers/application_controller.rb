class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:create]
  protected

  def configure_permitted_parameters
    attributes = [:name, :surname,:username, :email, :avatar, :phone_number, :gender]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
    devise_parameter_sanitizer.permit(:sign_in, keys: attributes)
    devise_parameter_sanitizer.permit(:account_update, keys: attributes)
  end
end
