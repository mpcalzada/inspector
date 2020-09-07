class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  before_action :authenticate_user!, :except => :landing
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :cor

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstName, :lastName, :birthday, :username, :phone])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username, :firstName, :email, :password, :remember_me, :birthday, :nameProfile_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstName, :lastName, :birthday, :username, :phone])
  end

  def cor
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE}.join(",")
    headers["Access-Control-Allow-Headers"] = %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
    head(:ok) if request.request_method == "OPTIONS"
  end
end