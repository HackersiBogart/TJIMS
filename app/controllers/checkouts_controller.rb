class CheckoutsController < ApplicationController
  def new
    @cart = retrieve_cart
    @total_price = calculate_total_price(@cart)
    @admin_order = Order.new
  end

  def create
    @checkout = Checkout.new(checkout_params)

 
      if @checkout.save
        # Redirect to the unfulfilled orders page after saving checkout details
        redirect_to unfulfilled_orders_path, notice: "Checkout completed successfully."
      else
        @cart = retrieve_cart
        @total_price = calculate_total_price(@cart)
        render :new
      end

  end

  def payment_options
    # Render the view with payment options
  end

  def walk_in_payment
    # Handle walk-in payment logic here
    @checkout = current_checkout # Assuming you have a method to get the current checkout

    # Render a confirmation or redirect as needed
    redirect_to success_checkouts_path, notice: "Your order is placed. Please visit the store to complete your payment."
  end

  def online_payment
    # Redirect to the 'new' action of the checkouts controller
    redirect_to new_checkout_path
  end

  private

  def checkout_params
    params.require(:checkout).permit(:reference_number, :date_of_retrieval, :receipt_image, :name, :phone_number)
  end

  def retrieve_cart
    session[:cart] || []
  end

  def calculate_total_price(cart)
    cart.sum { |item| item["price"].to_i * item["quantity"].to_i }
  end

  def current_checkout
    # Method to retrieve the current checkout, depending on your implementation
    Checkout.last
  end
end
