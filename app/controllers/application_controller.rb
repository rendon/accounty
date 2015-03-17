require 'digest/md5'
# Base controller
class ApplicationController < ActionController::Base
  include SessionsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def check_logged_in
    return if logged_in?
    flash[:danger] = MESSAGES[:auth_error]
    redirect_to login_path
  end

  def check_right_user
    if params[:user_id].to_i != current_user.id
      flash[:danger] = MESSAGES[:auth_error]
      redirect_to user_companies_path(current_user)
    end
  end

  def check_right_company
    user = User.find(params[:user_id])
    company = user.companies.find_by(id: params[:company_id])
    unless company
      flash[:info] = MESSAGES[:not_found]
      redirect_to user_companies_path(current_user)
    end
  end
end
