# Controller for Accounts
class AccountsController < ApplicationController
  before_action :check_logged_in
  before_action :check_right_user
  before_action :check_right_company

  def index
    @user = current_user
    @company = @user.companies.find_by(id: params[:company_id])
    @accounts = @company.accounts
  end

  def new
    @user = current_user
    @company = @user.companies.find_by(id: params[:company_id])
    @account = @company.accounts.new
  end

  def create
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

  def show
    @user = current_user
    @company = @user.companies.find(params[:company_id])
    @account = @company.accounts.find(params[:id])
  end

  private

  def account_params
    params.require(:account)
      .permit(:name, :description, :category, :subcategory)
  end

  def check_right_user
    return if params[:user_id].to_i == current_user.id
    flash[:danger] = MESSAGES[:access_error]
    redirect_to user_path(current_user)
  end

  def check_right_company
    company = current_user.companies.find_by(id: params[:company_id])
    unless company
      flash[:info] = MESSAGES[:not_found]
      redirect_to user_companies_path(current_user)
    end
  end
end
