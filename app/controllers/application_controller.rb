require 'digest/md5'
# Base controller
class ApplicationController < ActionController::Base
  include SessionsHelper
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def check_logged_in
    return if logged_in?
    flash[:danger] = MESSAGES[:auth_error]
    session[:previous_url] = request.fullpath
    redirect_to login_path
  end

end
