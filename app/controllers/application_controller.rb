class ApplicationController < ActionController::Base
  before_action

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstName, :lastName, :birthday, :username, :phone])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :firstName, :email, :password, :remember_me, :birthday, :nameProfile_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstName, :lastName, :birthday, :username, :phone])

  end
end