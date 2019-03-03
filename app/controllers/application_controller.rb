class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :save_requested_url

  private

  def save_requested_url
    cookies[:redirect_url] = request.original_url
  end

  def after_sign_in_path_for(user)
    flash[:notice] = "Hello, #{user.first_name}!"
    user.admin? ? admin_tests_path : cookies[:redirect_url] || tests_path
  end
end
