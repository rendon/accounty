module SessionsHelper
  def authenticate(params)
    User.find_by(email: params[:email]).try(:authenticate, params[:password])
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end
end
