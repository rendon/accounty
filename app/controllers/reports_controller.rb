class ReportsController < ApplicationController
  before_action :check_logged_in
  before_action :check_right_company

  def new
    @user = current_user
    @company = current_user.companies.find(params[:company_id])
    if params[:start_date] && params[:end_date]
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      @operations = report(@company, @start_date, @end_date)
    else
      @start_date = date_to_str(Time.now.beginning_of_month)
      @end_date = date_to_str(Time.now)
    end
  end

  def xlsx
    @company = current_user.companies.find(params[:company_id])
    @operations = report(@company, params[:start_date], params[:end_date])
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Report.xlsx"'
      }
    end
  end

  private

  def report(company, start_date, end_date)
    sql = 'created_at >= :start_date AND created_at <= :end_date'
    parameters = { start_date: str_to_date(start_date),
                   end_date: str_to_date(end_date).end_of_day }
    company.operations.where(sql, parameters)
  end

  def check_right_company
    company = current_user.companies.find_by(id: params[:company_id])
    unless company
      flash[:info] = MESSAGES[:not_found]
      redirect_to user_companies_path(current_user)
    end
  end
end
