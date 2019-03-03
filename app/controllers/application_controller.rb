class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :save_requested_url

  private

  def save_requested_url
    cookies[:redirect_url] = request.original_url
  end
end
