class EmailsController < ApplicationController
  def new
  end

  def create
    receiver_email = params[:email]

    # Error handling during email sending
    begin
      # Attempt to send the email
      EmailMailer.send_email(receiver_email).deliver_now
      flash[:notice] = 'Email has been sent!'
      redirect_to new_email_path
    rescue StandardError => e
      # Log the error for debugging
      logger.error "Failed to send email: #{e.message}"

      # Display a flash message to the user
      flash[:alert] = "There was an error sending the email: #{e.message}"
      render :new
    end
  end
end
