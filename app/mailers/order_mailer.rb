

class OrderMailer < ApplicationMailer
  def fulfillment_email(email, name)
    @name = name
    mail(to: email, subject: "Order Fulfillment Notification")
  end
end


