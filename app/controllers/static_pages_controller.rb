# Controller for Static Pages
class StaticPagesController < ApplicationController
  def home
    if current_user
      redirect_to user_companies_path(current_user.id)
    else
      render :home
    end
  end

  def help
  end

  def about
  end
end
