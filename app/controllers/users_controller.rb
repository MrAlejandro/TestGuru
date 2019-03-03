class UsersController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :save_requested_url

  def new
    return redirect_to root_path if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to tests_path
      session[:user_id] = @user.id
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
