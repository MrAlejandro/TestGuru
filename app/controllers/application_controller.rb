class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :save_requested_url
  before_action :authenticate_user!

  helper_method :current_user, :logged_in?

  private

  def authenticate_user!
    redirect_to login_path, alert: "Are you a Guru? Verify your Email and Password please" unless current_user
    cookies[:email] = current_user&.email
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def save_requested_url
    cookies[:redirect_url] = request.original_url
  end
end
