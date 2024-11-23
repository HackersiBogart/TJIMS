class Admin::UsersController < ApplicationController
    before_action :set_user, only: [:send_welcome_email]

  
    def index
      @users = User.all
    end
  
    def send_welcome_email
      # If you want to use the email input instead of the user's saved email
      email = params[:email] || @user.email
      UserMailer.welcome_email(@user, email).deliver_now
      redirect_to admin_users_path, notice: "Welcome email sent to #{email}."
    end

        def send_email
          user = User.find(params[:id])
          # Assuming you have a mailer that handles sending emails
          UserMailer.welcome_email(user).deliver_now
          flash[:notice] = "Email sent to #{user.name}"
          redirect_to admin_users_path
        end

      
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
      
      def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          redirect_to admin_users_path, notice: "User was successfully updated."
        else
          render :edit
        end
      end
      
  end
  