class Admin::OrderMailer < ApplicationMailer
  def new_order_email
    @admin_order = params[:order]

    mail(to: <customer_email>, subject: "You got a new order!")
  end
end
