# Preview all emails at http://localhost:3000/rails/mailers/admin/order_mailer
class Admin::OrderMailerPreview < ActionMailer::Preview
  def new_order_email
    # Set up a temporary order for the preview
    order = Order.new(name: "Joe Smith", email: "joe@gmail.com", address: "1-2-3 Chuo, Tokyo, 333-0000", phone: "090-7777-8888", message: "I want to place an order!")

    OrderMailer.with(order: order).new_order_email
  end
end
