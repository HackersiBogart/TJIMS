class Admin::OrdersController < AdminController
  before_action :set_admin_order, only: %i[ show edit update destroy ]

  # GET /admin/orders or /admin/orders.json
 # GET /admin/orders or /admin/orders.json
def index
  # Orders sorted by latest created_at date first
  @not_fulfilled_pagy, @not_fulfilled_orders = pagy(Order.where(fulfilled: false).order(created_at: :desc))
  @fulfilled_pagy, @fulfilled_orders = pagy(Order.where(fulfilled: true).order(created_at: :desc), page_param: :page_fulfilled)
  @query = params[:query]&.downcase

  if @query.present?
    # Use LIKE for case-insensitive matching in SQLite
    @not_fulfilled_orders = Order.where(fulfilled: false)
                                 .where("CAST(id AS TEXT) LIKE :search OR LOWER(name) LIKE :search OR CAST(date_of_retrieval AS TEXT) LIKE :search", search: "%#{@query}%")
                                 .order(created_at: :desc)

    @fulfilled_orders = Order.where(fulfilled: true)
                             .where("CAST(id AS TEXT) LIKE :search OR LOWER(name) LIKE :search OR CAST(date_of_retrieval AS TEXT) LIKE :search", search: "%#{@query}%")
                             .order(created_at: :desc)
  else
    # Display all unfulfilled and fulfilled orders if no search query is provided
    @not_fulfilled_orders = Order.where(fulfilled: false).order(created_at: :desc)
    @fulfilled_orders = Order.where(fulfilled: true).order(created_at: :desc)
  end

  # Paginate the results using Pagy
  @not_fulfilled_pagy, @not_fulfilled_orders = pagy(@not_fulfilled_orders, items: 10)
  @fulfilled_pagy, @fulfilled_orders = pagy(@fulfilled_orders, items: 10)



end

def change_fulfilled
  @order = Order.find(params[:id])
  @order.fulfilled = !@order.fulfilled # Toggle fulfillment status
  if @order.save
    redirect_to admin_orders_path, notice: 'Order fulfillment status updated successfully.'
  else
    redirect_to admin_order_path(@order), alert: 'Failed to update order fulfillment status.'
  end
end
  # GET /admin/orders/1 or /admin/orders/1.json
  def show
    @order = Order.find(params[:id])
    @paint_color = @order.paint_color # Assuming an order has one paint color
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_order
      @admin_order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_order_params
      params.require(:order).permit(:customer_email, :fulfilled,:name, :phone_number, :reference_number, :image, :date_of_retrieval, :total, :size,:quantity, :item, :paint_color_id, :color_id,:product_id, :primary_color_id, :order_total)
    end
end