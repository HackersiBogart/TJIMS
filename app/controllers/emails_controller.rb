class EmailsController < ApplicationController
  def new
  end

  def create
    receiver_email = params[:email]
    EmailMailer.send_email(receiver_email).deliver_now
    flash[:notice] = 'Email has been sent!'
    redirect_to new_email_path
  end
end
