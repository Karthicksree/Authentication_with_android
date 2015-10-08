class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :user_base

  def after_sign_in_path_for(resource)
    posts_path
  end

  def user_base
    user_signed_in? ? "dashboard" : "application"
  end

end
