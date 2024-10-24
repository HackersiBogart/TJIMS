class CheckoutsController < ApplicationController
  def new
    @cart = retrieve_cart
    @total_price = calculate_total_price(@cart)
    @admin_order = Order.new  # Renaming from @admin_order to @order for clarity
    @cart_items = @cart  # Pass cart items to the view
  end

  def create
    @admin_order = Order.new(checkout_params)  # Now using order_params

    @cart = retrieve_cart

    if @admin_order.save
      save_cart_items_to_order(@admin_order, @cart)  # Save cart items to the order
      session[:cart] = []  # Clear the cart after successful checkout

      # Redirect to payment_options_path after saving checkout details
      redirect_to checkouts_payment_options_path, notice: "Checkout completed successfully. Please select a payment option."
    else
      @cart = retrieve_cart
      @total_price = calculate_total_price(@cart)
      render :new  # Re-render the form if there is an error
    end
  end

  def payment_options
    redirect_to checkouts_payment_options_path
  end

  def retrieve_cart
    session[:cart] || []
  end

  def save_cart_items_to_order(admin_order, cart)
    cart.each do |item|
      paint_color = PaintColor.find(item["paint_color_id"])
      
      # Create an OrderPaintColor or similar model to associate the cart item with the order
      admin_order.order_paint_colors.create!(
        paint_color: paint_color,
        quantity: item["quantity"],
        size: item["size"],
        price: item["price"] # assuming this is the price per unit
      )

      # Optionally reduce stock
      reduce_stock(paint_color, item["quantity"])
    end
  end

  def online_payment
    # Redirect to the 'new' action of the checkouts controller
    redirect_to new_checkout_path
  end

  private

  def checkout_params
    params.require(:checkout).permit(:customer_email, :name, :phone_number, :reference_number, :image, :date_of_retrieval, :total, :size, :quantity, :items)
  end

  def calculate_total_price(cart)
    cart.sum { |item| item["price"].to_f * (item["quantity"].to_i + fraction_to_decimal(item["size"])) }
  end

  def fraction_to_decimal(fraction)
    case fraction
    when "1/16" then 0.0625
    when "1/8" then 0.125
    when "1/4" then 0.25
    when "1/2" then 0.5
    when "3/4" then 0.75
    else 0
    end
  end

  def reduce_stock(paint_color, quantity)
    if paint_color.stock >= quantity
      paint_color.update(stock: paint_color.stock - quantity)
    else
      raise "Insufficient stock for #{paint_color.name}."
    end
  end

  def current_checkout
    # Method to retrieve the current checkout, depending on your implementation
    Checkout.last
  end
end
