class OrderMailController < ApplicationController
  def send_mail
    email = params[:email]
    name = params[:name]
  
    OrderMailer.fulfillment_email(email, name).deliver_now
    redirect_to admin_order_mail_path, notice: "Notification email has been sent"
  end
  

  def new
  end
    
end