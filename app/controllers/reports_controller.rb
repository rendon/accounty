class ReportsController < ApplicationController
  before_action :check_logged_in
  before_action :check_right_company

  def new
    @user = current_user
    @company = current_user.companies.find(params[:company_id])
    @start_date = date_to_str(Time.now.beginning_of_month)
    @end_date = date_to_str(Time.now)
  end

  def create
    @user = current_user
    @company = current_user.companies.find(params[:company_id])
    @start_date = params[:report][:start_date]
    @end_date = params[:report][:end_date]
    sql = 'created_at >= :start_date AND created_at <= :end_date'
    parameters = { start_date: str_to_date(@start_date),
                   end_date: str_to_date(@end_date).end_of_day }
    @operations = @company.operations.where(sql, parameters)
    render :new
  end
  
  private

  def check_right_company
    company = current_user.companies.find_by(id: params[:company_id])
    unless company
      flash[:info] = MESSAGES[:not_found]
      redirect_to user_companies_path(current_user)
    end
  end
end
