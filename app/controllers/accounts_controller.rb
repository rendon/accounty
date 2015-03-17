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
end
