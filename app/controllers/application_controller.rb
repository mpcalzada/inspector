class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery prepend: true
  before_action :authenticate_user!, :except => :landing
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstName, :lastName, :birthday, :username, :phone])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :firstName, :email, :password, :remember_me, :birthday, :nameProfile_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstName, :lastName, :birthday, :username, :phone])

  end
end