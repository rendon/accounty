class StaticPagesController < ApplicationController
  def home
    if current_user
      render :dashboard
    else
      render :home
    end
  end

  def help

  end

  def about

  end
end
