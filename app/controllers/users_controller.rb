class UsersController < ApplicationController
  def new
    if current_user
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Your account was created successfully.'
      login_as(@user)
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    if current_user
    @user = current_user
    else
      flash[:danger] = MESSAGES[:auth_error]
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :password,
                                 :password_confirmation)
  end
end
