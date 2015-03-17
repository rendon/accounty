class OperationDetailsController < ApplicationController
  before_action :check_logged_in
  before_action :check_right_user
  before_action :check_right_company
  before_action :check_right_operation

  def create
    @user = current_user
    @company = @user.companies.find_by(id: params[:company_id])
    @operation = @company.operations.find_by(id: params[:operation_id])
    @operation_detail = @operation.operation_details.build(operation_detail_params)
    if @operation_detail.save
      flash[:success] = 'Detail added successfully.'
      redirect_to user_company_operation_path(@user, @company, @operation)
    else
      @operation_details = @operation.operation_details
      render 'operations/show'
    end
  end

  private

  def operation_detail_params
    params.require(:operation_detail).permit(:account_id, :amount)
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

  def check_right_operation
    company = current_user.companies.find(params[:company_id])
    operation = company.operations.find_by(id: params[:operation_id])
    unless operation
      flash[:info] = MESSAGES[:not_found]
      redirect_to user_companies_path(current_user)
    end
  end
end
