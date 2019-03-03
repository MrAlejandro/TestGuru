class SessionsController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :save_requested_url

  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      login
      redirect_to cookies[:redirect_url] || tests_path
    else
      flash.now[:alert] = "Are you a Guru? Verify your Email and Password please"
      render :new
    end
  end

  def destroy
    logout
    redirect_to cookies[:redirect_url] || tests_path
  end

  private

  def login
    session[:user_id] = @user.id
  end

  def logout
    session[:user_id] = nil
  end
end
