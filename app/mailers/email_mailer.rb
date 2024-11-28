class EmailMailer < ApplicationMailer
  default from: 'stockoptimatj@gmail.com'

  def send_email(receiver_email)
    @receiver_email = receiver_email
    mail(
      to: @receiver_email, 
      subject: 'Your Order Has Been Fulfilled! 🎉',
      body: <<~BODY
        Dear Customer,

        We are delighted to inform you that your order has been successfully fulfilled and is ready for you! 🎉

        Your order is now ready for pickup at our store:
        Every Monday to Friday
        from 9:00 a.m. to 5:00 p.m.
        TJ Paint Center
        Vinzons Ave., Daet, Camarines Norte

        Want to shop with us again? Click this link: https://tjims-ckom.onrender.com

        Warm regards,
        TJ Stock Optima
      BODY
    )
  end
end
