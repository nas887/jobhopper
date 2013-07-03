class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user
      sign_in(user)
      redirect_to user_path(user)
    else
      redirect_to '/'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
