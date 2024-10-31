class OrderMailer < ApplicationMailer
  default from: 'arjaydelafuente87@gmail.com' # Replace with your sender email

  def fulfillment_email(order)
    @order = order
    mail(to: @order.customer_email, subject: "Your Order Has Been Fulfilled")
  end
end
