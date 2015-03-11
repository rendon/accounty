class CompaniesController < ApplicationController
  def index
    unless logged_in?
      redirect_to root_path
      flash[:danger] = "You're not authorized to see this resource."
      return
    end
    @user = current_user
    @companies = @user.companies
  end

  def new
    unless logged_in?
      redirect_to root_path
      return
    end

    @user = current_user
    @company = current_user.companies.build if logged_in?
  end

  def create
    unless logged_in?
      redirect_to root_path
      return
    end

    user = User.find_by(id: current_user.id)
    user.companies.build(company_params)
    if user.save
      redirect_to user_companies_path(current_user)
    else
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :description, :logo)
  end
end
