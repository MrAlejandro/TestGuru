class Admin::SessionsController < Devise::SessionsController
  after_filter :after_login, only: :create

  private

  def after_login
    redirect_to admin_tests_path if current_user.is_a?(Admin)
  end
end
