class Admin::OrderMailer < ApplicationMailer
  def new_order_email
    @admin_order = params[:order]
    mail(to: @admin_order.customer_email, subject: "You got a new order!") # Adjusted here
  end
end
