class Admin::StocksController < AdminController
  before_action :set_admin_stock, only: %i[ show edit update destroy ]


  # GET /admin/stocks or /admin/stocks.json
  def index
    @admin_stocks = Stock.where(paint_color_id: params[:paint_color_id])
  end

  # GET /admin/stocks/1 or /admin/stocks/1.json
  def show
 
    @admin_stock = Stock.find(params[:id])
  end

  # GET /admin/stocks/new
  def new
    @paint_color = PaintColor.find(params[:paint_color_id])
    @admin_stock = Stock.new
  end

  # GET /admin/stocks/1/edit
  def edit

    @admin_stock = Stock.find(params[:id])
  end

  # POST /admin/stocks or /admin/stocks.json
  def create
    @paint_color = PaintColor.find(params[:paint_color_id])
    @admin_stock = @paint_color.stocks.new(admin_stock_params)

    respond_to do |format|
      if @admin_stock.save
        format.html { redirect_to admin_paint_color_stock_url(@paint_color, @admin_stock), notice: "Stock was successfully created." }
        format.json { render :show, status: :created, location: @admin_stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/stocks/1 or /admin/stocks/1.json
  def update
    respond_to do |format|
      if @admin_stock.update(admin_stock_params)
        format.html { redirect_to admin_paint_color_stock_url(@admin_stock.paint_color, @admin_stock), notice: "Stock was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/stocks/1 or /admin/stocks/1.json
  def destroy
    @admin_stock.destroy!

    respond_to do |format|
      format.html { redirect_to admin_paint_color_stocks_url, notice: "Stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_stock
    @admin_stock = Stock.find_by(params[:id])
    
  end

  # Only allow a list of trusted parameters through.
  def admin_stock_params
    params.require(:stock).permit(:size, :amount, :price, :unit)
  end



  
  
end
