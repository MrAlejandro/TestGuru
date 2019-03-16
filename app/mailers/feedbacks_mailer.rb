class FeedbacksMailer < ApplicationMailer
  def feedback(feedback)
    @user = feedback.user
    @body = feedback.body
    admin = Admin.first

    mail to: admin.email if admin.email
  end
end
