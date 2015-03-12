class CompaniesController < ApplicationController
  def index
    unless logged_in?
      redirect_to root_path
      flash[:danger] = MESSAGES[:auth_error]
      return
    end
    @user = current_user
    @companies = @user.companies
  end

  def show
    unless logged_in? && current_user.id == params[:user_id].to_i
      flash[:danger] = MESSAGES[:auth_error]
      redirect_to root_path
      return
    end

    @user = User.find_by(id: current_user.id)
    @company = Company.find_by(user_id: params[:user_id], id: params[:id])
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
    company = user.companies.build(company_params)
    logo = company_params[:logo]
    if logo && logo.is_a?(ActionDispatch::Http::UploadedFile)
      data = Cloudinary::Uploader.upload(logo.path)
      company.logo = "#{data['public_id']}.#{data['format']}"
    else
      company.logo = 'company_logo.png'
    end

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
