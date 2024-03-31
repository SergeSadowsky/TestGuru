class SessionsController < ApplicationController

  skip_before_action :authenticate_user!
  def new

  end

  def create
    user = User.find_by_email(params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to(cookies.delete(:intended_url) || tests_path)
    else
      flash.now[:alert] = 'Are you a Guru? Verify your Email and Password please'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "You're logged out."
  end

end
