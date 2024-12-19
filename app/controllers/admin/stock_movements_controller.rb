class Admin::StockMovementsController < AdminController
  before_action :set_stock_movement, only: %i[show edit update destroy]

  # GET /admin/stock_movements or /admin/stock_movements.json
  def index

    @admin_paint_colors = PaintColor.where(params[:paint_color_id])
    @admin_primary_colors = PrimaryColor.where(params[:primary_color_id])
    
    # Calculate previous stocks, added stocks, and current quantity

      
  
    @not_fulfilled_pagy, @not_fulfilled_orders = pagy(Order.where(fulfilled: false).includes(:product, :primary_color, :paint_color).order(created_at: :desc))
    @fulfilled_pagy, @fulfilled_orders = pagy(Order.where(fulfilled: true).includes(:product, :primary_color, :paint_color).order(created_at: :desc), page_param: :page_fulfilled)
  
    @query = params[:query]&.downcase

    if @query.present?
      # Search logic for not fulfilled orders
      @not_fulfilled_orders = Order.where(fulfilled: false)
                                   .includes(:product, :primary_color, :paint_color, :color)
                                   .where("CAST(id AS TEXT) LIKE :search OR LOWER(name) LIKE :search OR CAST(date_of_retrieval AS TEXT) LIKE :search", search: "%#{@query}%")
                                   .order(created_at: :desc)

        # Search logic for fulfilled orders
      @fulfilled_orders = Order.where(fulfilled: true)
                               .includes(:product, :primary_color, :paint_color, :color)
                               .where("CAST(id AS TEXT) LIKE :search OR LOWER(name) LIKE :search OR CAST(date_of_retrieval AS TEXT) LIKE :search", search: "%#{@query}%")
                               .order(created_at: :desc)
    else
      # Default display if no search query is provided
      @not_fulfilled_orders = Order.where(fulfilled: false).includes(:product, :primary_color, :paint_color).order(created_at: :desc)
      @fulfilled_orders = Order.where(fulfilled: true).includes(:product, :primary_color, :paint_color).order(created_at: :desc)
    end

    # Paginate the results using Pagy
    @not_fulfilled_pagy, @not_fulfilled_orders = pagy(@not_fulfilled_orders, items: 10)
    @fulfilled_pagy, @fulfilled_orders = pagy(@fulfilled_orders, items: 10)
  end

  # GET /admin/stock_movements/new
  def new
    @stock_movement = StockMovement.new
  end

  # POST /admin/stock_movements
  def create
    @stock_movement = StockMovement.new(stock_movement_params)
    if @stock_movement.save
      redirect_to admin_stock_movements_path, notice: "Stock movement recorded successfully."
    else
      render :new, alert: "Failed to record stock movement."
    end
  end

  # GET /admin/stock_movements/1/edit
  def edit
  end

  # PATCH/PUT /admin/stock_movements/1
  def update
    @admin_paint_color = PaintColor.find(params[:id])
    @order = Order.find(params[:id])
    deducted_quantity = @order.quantity
    previous_quantity = @admin_paint_color.quantity
      new_quantity = params[:paint_color][:quantity].to_i

      @admin_paint_color.deducted_stocks = deducted_quantity
      @admin_paint_color.previous_stocks = previous_quantity
      @admin_paint_color.added_stocks = new_quantity - previous_quantity
      @admin_paint_color.quantity = new_quantity
      @admin_paint_color.updated_at = Time.current # This might be automatically handled by Rails, depending on your setup.

      @admin_primary_color = PrimaryColor.find(params[:id])
    
    # Calculate previous stocks, added stocks, and current quantity
    previous_quantity = @admin_primary_color.stocks
    new_stocks = params[:primary_color][:stocks].to_i
    
    @admin_primary_color.deducted_stocks = deducted_quantity
    @admin_primary_color.previous_stocks = previous_stocks
    @admin_primary_color.added_stocks = new_stocks - previous_stocks
    @admin_primary_color.stocks = new_stocks
    @admin_primary_color.updated_at = Time.current # This might be automatically handled by Rails, depending on your setup.
    respond_to do |format|
      if @stock_movement.update(stock_movement_params)
        format.html { redirect_to admin_stock_movement_path(@stock_movement), notice: "Stock movement was successfully updated." }
        format.json { render :show, status: :ok, location: @stock_movement }
      else
        format.html { render :edit }
        format.json { render json: @stock_movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/stock_movements/1
  def destroy
    @stock_movement.destroy!

    respond_to do |format|
      format.html { redirect_to admin_stock_movements_url, notice: "Stock movement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stock_movement
    @stock_movement = StockMovement.find(params[:id]) if params[:id]
  end

  # Only allow a list of trusted parameters through.
  def stock_movement_params
    params.require(:stock_movement).permit(:product_id, :primary_color_id, :paint_color_id, :order_id, :color_id, :movement_type, :quantity)
  end
end
