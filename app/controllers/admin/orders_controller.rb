class Admin::OrdersController < AdminController
  before_action :set_admin_order, only: %i[show edit update destroy manage_mixture save_mixture]

  # GET /admin/orders or /admin/orders.json
  def index
    @not_fulfilled_pagy, @not_fulfilled_orders = pagy(Order.where(fulfilled: false).order(created_at: :desc))
    @fulfilled_pagy, @fulfilled_orders = pagy(Order.where(fulfilled: true).order(created_at: :desc), page_param: :page_fulfilled)
    @query = params[:query]&.downcase

    if @query.present?
      @not_fulfilled_orders = Order.where(fulfilled: false)
                                   .where("CAST(id AS TEXT) LIKE :search OR LOWER(name) LIKE :search OR CAST(date_of_retrieval AS TEXT) LIKE :search", search: "%#{@query}%")
                                   .order(created_at: :desc)

      @fulfilled_orders = Order.where(fulfilled: true)
                               .where("CAST(id AS TEXT) LIKE :search OR LOWER(name) LIKE :search OR CAST(date_of_retrieval AS TEXT) LIKE :search", search: "%#{@query}%")
                               .order(created_at: :desc)
    else
      @not_fulfilled_orders = Order.where(fulfilled: false).order(created_at: :desc)
      @fulfilled_orders = Order.where(fulfilled: true).order(created_at: :desc)
    end

    @not_fulfilled_pagy, @not_fulfilled_orders = pagy(@not_fulfilled_orders, items: 10)
    @fulfilled_pagy, @fulfilled_orders = pagy(@fulfilled_orders, items: 10)
  end

  # GET /admin/orders/1 or /admin/orders/1.json
  def show
    @order = Order.find(params[:id])
    @paint_color = @order.paint_color
  end

  def reference_image
    order = Order.find(params[:id])
    image_url = order.image.attached? ? url_for(order.image) : nil
    render json: { image_url: image_url }
  end

  # GET /admin/orders/new
  def new
    @admin_order = Order.new
  end

  # GET /admin/orders/1/edit
  def edit
    @order = Order.find_by(id: params[:id])
  end

  # POST /admin/orders or /admin/orders.json
  def create
    @admin_order = Order.new(admin_order_params)

    respond_to do |format|
      if @admin_order.save
        format.html { redirect_to admin_order_url(@admin_order), notice: "Order was successfully created." }
        format.json { render :show, status: :created, location: @admin_order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/orders/1 or /admin/orders/1.json
  def update
    respond_to do |format|
      if @admin_order.update(admin_order_params)
        send_email(@admin_order) if @admin_order.fulfilled
        format.html { redirect_to admin_order_url(@admin_order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_order }
      else
        format.html { render :edit }
        format.json { render json: @admin_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/orders/1 or /admin/orders/1.json
  def destroy
    @admin_order.destroy!

    respond_to do |format|
      format.html { redirect_to admin_orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /admin/orders/1/manage_mixture
  def manage_mixture
    @mixture_details = @admin_order.mixture_details || []
    @mixture_thirds = @admin_order.mixture_thirds || []

    @admin_order.mixture_details.build if @mixture_details.empty?
    @admin_order.mixture_thirds.build if @mixture_thirds.empty?
  end

  # POST or PATCH /admin/orders/1/save_mixture
  def save_mixture
    @admin_order = Order.find(params[:id])

    respond_to do |format|
      if @admin_order.update(order_with_mixture_params)
        format.html { redirect_to admin_order_url(@admin_order), notice: "Mixture details were successfully saved to the order." }
        format.json { render :show, status: :ok, location: @admin_order }
      else
        format.html { render :manage_mixture, status: :unprocessable_entity }
        format.json { render json: @admin_order.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Callback to set the current order
  def set_admin_order
    @admin_order = Order.find(params[:id])
  end

  # Strong parameters for order
  def admin_order_params
    params.require(:order).permit(:customer_email, :fulfilled, :name, :phone_number, :reference_number, :image, :date_of_retrieval, :total, :size, :quantity, :item, :paint_color_id, :color_id, :product_id, :primary_color_id, :order_total)
  end

  # Strong parameters for order with nested mixture attributes
  def order_with_mixture_params
    params.require(:order).permit(
      :customer_email,
      :fulfilled,
      :name,
      :phone_number,
      :reference_number,
      :image,
      :date_of_retrieval,
      :total,
      :size,
      :quantity,
      :item,
      :paint_color_id,
      :color_id,
      :product_id,
      :primary_color_id,
      :order_total,
      mixture_details_attributes: %i[id primary_color_id amount _destroy],
      mixture_thirds_attributes: %i[id primary_color_id amount _destroy]
    )
  end

  # Send an email notification upon fulfillment
  def send_email(order)
    EmailMailer.send_email(order.customer_email).deliver_now
    flash[:notice] = 'Email has been sent!'
  end
end
