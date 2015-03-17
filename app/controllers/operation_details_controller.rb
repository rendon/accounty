class OperationDetailsController < ApplicationController
  before_action :check_logged_in
  before_action :check_right_user
  before_action :check_right_company

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
end
