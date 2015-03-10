class SessionsController < ApplicationController
  def new
    if current_user
      redirect_to user_path(current_user)
    end
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

  def destroy
    session.delete(:user_id)
    redirect_to root_path
  end
end
