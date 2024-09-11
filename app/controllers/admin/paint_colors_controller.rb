class Admin::PaintColorsController < AdminController
  before_action :set_admin_paint_color, only: %i[ show edit update destroy ]

  # GET /admin/paint_colors or /admin/paint_colors.json
  def index
    @admin_paint_colors = PaintColor.where(params[:paint_color_id])
    
  end

  # GET /admin/paint_colors/1 or /admin/paint_colors/1.json
  def show
  end

  # GET /admin/paint_colors/new
  def new
    @admin_paint_color = PaintColor.new
  end

  # GET /admin/paint_colors/1/edit
  def edit
  end

  # POST /admin/paint_colors or /admin/paint_colors.json
  def create
    @admin_paint_color = PaintColor.new(admin_paint_color_params)

    respond_to do |format|
      if @admin_paint_color.save
        format.html { redirect_to admin_paint_color_url(@admin_paint_color), notice: "Paint color was successfully created." }
        format.json { render :show, status: :created, location: @admin_paint_color }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_paint_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/paint_colors/1 or /admin/paint_colors/1.json
  def update
    respond_to do |format|
      if @admin_paint_color.update(admin_paint_color_params)
        format.html { redirect_to admin_paint_color_url(@admin_paint_color), notice: "Paint color was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_paint_color }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_paint_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/paint_colors/1 or /admin/paint_colors/1.json
  def destroy
    @admin_paint_color.destroy!

    respond_to do |format|
      format.html { redirect_to admin_paint_colors_url, notice: "Paint color was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_paint_color
      @admin_paint_color = PaintColor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_paint_color_params
      params.require(:paint_color).permit(:name, :code, :size, :quantity, :price, :product_id, :active , :image)
    end
end
