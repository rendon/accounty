class SessionsController < ApplicationController
  def new
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
    redirect_to user_path(current_user)
  end
end
