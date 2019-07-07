class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url = "http://example.com/login"
    mail(to: @user.email, subject: "Welcome!")
  end

  def password_reset_email
    @user = params[:user]
    mail(to: @user.email, subject: "Password reset")
  end
end
