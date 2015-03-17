# Helper for sessions
module SessionsHelper
  def authenticate(params)
    User.find_by(email: params[:email]).try(:authenticate, params[:password])
  end

  def login_as(user, _options = {})
    session[:user_id] = user.id
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
