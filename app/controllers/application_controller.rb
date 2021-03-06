class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :unescape_notice
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  private

  def unescape_notice
    flash.now[:notice] = flash[:notice].html_safe if flash[:html_safe] && flash[:notice]
    flash.delete(:html_safe)
  end

  def default_url_options
    I18n.locale == I18n.default_locale ? {} : { lang: I18n.locale }
  end

  def after_sign_in_path_for(user)
    flash[:notice] = "Hello, #{user.first_name}!"
    user.admin? ? admin_tests_path : tests_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :first_name, :last_name, :password) }
  end

  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) ? params[:lang] : I18n.default_locale
  end
end
