class AccountsController < ApplicationController
  def index
    unless logged_in?
      flash[:danger] = MESSAGES[:auth_error]
      redirect_to root_path
      return
    end

    if params[:user_id].to_i != current_user.id
      flash[:danger] = MESSAGES[:auth_error]
      redirect_to user_companies_path(current_user)
      return
    end

    @user = current_user
    @company = Company.find_by(user_id: params[:user_id], id: params[:company_id])
    unless @company
      flash[:info] = MESSAGES[:not_found]
      redirect_to user_companies_path(current_user)
      return
    end
    @accounts = @company.accounts
  end

  def new
    unless logged_in? && current_user.id == params[:user_id].to_i
      flash[:danger] = MESSAGES[:auth_error]
      redirect_to root_path
      return
    end
    @user = current_user
    @company = @user.companies.find_by(id: params[:company_id])
    @account = @company.accounts.new
  end

  def create
    unless logged_in? && current_user.id == params[:user_id].to_i
      flash[:danger] = MESSAGES[:auth_error]
      redirect_to root_path
      return
    end

    @user = current_user
    @company = @user.companies.find_by(id: params[:company_id])
    @account = @company.accounts.build(account_params)
    if @company.save
      flash[:success] = 'Account added successfully.'
      redirect_to user_company_accounts_path(@user, @company)
    else
      render :new
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :description, :category, :subcategory)
  end
end
