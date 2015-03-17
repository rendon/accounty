# Controller for Operations
class OperationsController < ApplicationController
  before_action :check_logged_in
  before_action :check_right_user
  before_action :check_right_company

  def create
    @user = current_user
    @company = @user.companies.find_by(id: params[:company_id])
    @operation = @company.operations.build(operation_params)
    if @company.save
      flash[:success] = 'Operation successfully created.'
      redirect_to user_company_operation_path(@user, @company, @operation)
    else
      render :new
    end
  end

  def index
    @user = current_user
    @company = @user.companies.find_by(id: params[:company_id])
    @operations = @company.operations.order(:created_at).reverse
  end

  def new
    @user = current_user
    @company = @user.companies.find_by(id: params[:company_id])
    @operation = @company.operations.new
  end

  def show
    @user = current_user
    @company = @user.companies.find_by(id: params[:company_id])
    @operation = @company.operations.find_by(id: params[:id])
    @operation_detail = @operation.operation_details.new
    @operation_details = @operation.operation_details.order(:created_at).reverse
  end

  private

  def operation_params
    params.require(:operation).permit(:description)
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