# Controller for Sessions
class SessionsController < ApplicationController
  def new
    return unless current_user
    redirect_to user_path(current_user)
  end

  def create
    user = authenticate(params[:session])
    unless user
      flash[:danger] = 'Email and password combination do not match.'
      render :new
      return
    end
    session[:user_id] = user.id
    flash[:success] = "Welcome back #{current_user.name}!"
    if session[:previous_url]
      redirect_to session[:previous_url]
    else
      redirect_to root_path
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
