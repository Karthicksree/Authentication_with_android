class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :update_sanitized_params, if: :devise_controller?
  protect_from_forgery with: :exception
  layout :user_base

  def after_sign_in_path_for(resource)
    posts_path
  end

  def user_base
    user_signed_in? ? "dashboard" : "application"
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:name, :email, :password, :password_confirmation,:current_password,:mobile_number,:gender,:photo)}
  end

end
