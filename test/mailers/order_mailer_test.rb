class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/fulfilled
  def fulfillment_email
    # Find or create a sample order to use in the preview
    order = Order.first || Order.create(
      customer_email: "stockoptimatj@gmail.com",
      name: "Sample Customer",
      date_of_retrieval: Date.today,
      total: 100.0
    )

    OrderMailer.fulfillment_email(order)
  end

end
