class Admin::PrimaryColorStocksController < AdminController
  before_action :set_admin_primary_color_stock, only: %i[ show edit update destroy ]

  # GET /admin/primary_color_stocks or /admin/primary_color_stocks.json
  def index
    @admin_primary_color_stocks = PrimaryColorStock.where(primary_color_id: params[:primary_color_id])
   
  end

  # GET /admin/primary_color_stocks/1 or /admin/primary_color_stocks/1.json
  def show
  end

  # GET /admin/primary_color_stocks/new
  def new
    @primary_color = PrimaryColor.find(params[:primary_color_id])
    @admin_primary_color_stock = PrimaryColorStock.new



  end

  # GET /admin/primary_color_stocks/1/edit
  def edit
    @primary_color = PrimaryColor.find(params[:primary_color_id])
    @admin_primary_color_stock = PrimaryColorStock.find(params[:id])
  end

  # POST /admin/primary_color_stocks or /admin/primary_color_stocks.json
  def create
    @primary_color = PrimaryColor.find(params[:primary_color_id])
    @admin_primary_color_stock = @primary_color.primary_color_stocks.new(admin_primary_color_stock_params)
    
 

    respond_to do |format|
      if @admin_primary_color_stock.save
        format.html { redirect_to admin_primary_color_primary_color_stock_url(@primary_color, @admin_primary_color_stock), notice: "Primary color stock was successfully created." }
        format.json { render :show, status: :created, location: @admin_primary_color_stock }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_primary_color_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/primary_color_stocks/1 or /admin/primary_color_stocks/1.json
  def update
    respond_to do |format|
      if @admin_primary_color_stock.update(admin_primary_color_stock_params)
        format.html { redirect_to admin_primary_color_primary_color_stock_url(@admin_primary_color_stock.primary_color, @admin_primary_color_stock ), notice: "Primary color stock was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_primary_color_stock }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_primary_color_stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/primary_color_stocks/1 or /admin/primary_color_stocks/1.json
  def destroy
    @admin_primary_color_stock.destroy!

    respond_to do |format|
      format.html { redirect_to admin_primary_color_primary_color_stocks_url, notice: "Primary color stock was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_primary_color_stock
      @admin_primary_color_stock = PrimaryColorStock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_primary_color_stock_params
      params.require(:primary_color_stock).permit(:size, :quantity, :price)
    end
end
