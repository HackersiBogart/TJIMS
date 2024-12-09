class CustomerOrdersController < ApplicationController
  before_action :set_customer_order, only: %i[show edit update destroy]


  def fetch_products
    @products = Product.where(color_id: params[:color_id])
    render json: @products
  end
  
  # Fetch paint colors based on selected product
  def fetch_paint_colors
    @paint_colors = PaintColor.where(product_id: params[:product_id])
    render json: @paint_colors
  end
  # GET /customer_orders or /customer_orders.json
  def index
    @customer_orders = CustomerOrder.all
  end

  # GET /customer_orders/1 or /customer_orders/1.json
  def show
  end

  # GET /customer_orders/new
  def new
    @customer_order = CustomerOrder.new
    @colors = Color.all  # Ensure you have a Color model and fetch the colors
  end

  # GET /customer_orders/1/edit
  def edit
  end

  # POST /customer_orders or /customer_orders.json
  def create
    @customer_order = CustomerOrder.new(customer_order_params)

    respond_to do |format|
      if @customer_order.save
        # Create the AdminOrder with the same data and set fulfilled to false
        create_admin_order(@customer_order)

        format.html { redirect_to customer_order_url(@customer_order), notice: "Customer order was successfully created." }
        format.json { render :show, status: :created, location: @customer_order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_orders/1 or /customer_orders/1.json
  def update
    respond_to do |format|
      if @customer_order.update(customer_order_params)
        format.html { redirect_to customer_order_url(@customer_order), notice: "Customer order was successfully updated." }
        format.json { render :show, status: :ok, location: @customer_order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customer_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_orders/1 or /customer_orders/1.json
  def destroy
    @customer_order.destroy!

    respond_to do |format|
      format.html { redirect_to customer_orders_url, notice: "Customer order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_customer_order
    @customer_order = CustomerOrder.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def customer_order_params
    params.require(:customer_order).permit(:customer_email, :name, :phone_number, :reference_number, :date_of_retrieval, :total, :size, :quantity, :color_id, :product_id, :item, :image, :order_total)
  end

  # Create the AdminOrder after CustomerOrder is saved
  def create_admin_order(customer_order)
    admin_order = Order.new(
      customer_email: customer_order.customer_email,
      name: customer_order.name,
      phone_number: customer_order.phone_number,
      reference_number: customer_order.reference_number,
      date_of_retrieval: customer_order.date_of_retrieval,
      total: customer_order.total,
      order_total: customer_order.order_total,
      size: customer_order.size,
      quantity: customer_order.quantity,
      item: customer_order.item,
      fulfilled: false, # Ensure the order is marked as unfulfilled
      color_id: customer_order.color_id,
      product_id: customer_order.product_id
    )
    admin_order.image.attach(customer_order.image.blob) if customer_order.image.attached?
    admin_order.save!
  end
end
