
  class UserMailer < ApplicationMailer
    default from: 'stockoptimatj@gmail.com' # Update with your email
  
    def welcome_email(user)
      @user = user
      @url  = 'https://tjims-ckom.onrender.com'
      mail(to: @user.email, subject: 'Your order has been placed!')
    end
  end
