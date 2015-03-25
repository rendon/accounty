# Controller for Companies
class CompaniesController < ApplicationController
  before_action :check_logged_in
  before_action :check_right_user
  before_action :check_right_company, only: [:show]

  def index
    @user = current_user
    @companies = @user.companies
  end

  def show
    @user = User.find_by(id: current_user.id)
    @company = Company.find_by(user_id: params[:user_id], id: params[:id])
  end

  def new
    @user = current_user
    @company = current_user.companies.build
  end

  def create
    @user = User.find_by(id: current_user.id)
    @company = @user.companies.build(company_params)
    logo = company_params[:logo]
    @company.logo = 'company_logo.png'
    if logo && logo.is_a?(ActionDispatch::Http::UploadedFile)
      data = Cloudinary::Uploader.upload(logo.path)
      @company.logo = "#{data['public_id']}.#{data['format']}"
    end

    if @user.save
      redirect_to user_companies_path(current_user)
    else
      render :new
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :description, :logo)
  end

  def check_right_user
    return if params[:user_id].to_i == current_user.id
    flash[:danger] = MESSAGES[:access_error]
    redirect_to user_path(current_user)
  end

  def check_right_company
    company = current_user.companies.find_by(id: params[:id])
    unless company
      flash[:info] = MESSAGES[:not_found]
      redirect_to user_companies_path(current_user)
    end
  end
end
