

  class UserMailer < ApplicationMailer
    def welcome_email(user, email_override = nil)
      @user = user
      email = email_override || @user.email
      mail(to: email, subject: "Welcome to Our Platform!")
    end
  end
  