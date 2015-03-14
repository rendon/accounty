require 'digest/md5'
class ApplicationController < ActionController::Base
  include SessionsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def check_logged_in
    unless logged_in?
      flash[:danger] = MESSAGES[:auth_error]
      redirect_to login_path
    end
  end
end
