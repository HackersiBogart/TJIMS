class EmailMailer < ApplicationMailer
  default from: 'stockoptimatj@gmail.com'

  def send_email(receiver_email)
    @receiver_email = receiver_email
    mail(to: @receiver_email, subject: 'Hello from Rails App', body: 'This is a test email from your Rails app!')
  end
end
