class Admin::PrimaryColorsController < AdminController
  before_action :set_admin_primary_color, only: %i[ show edit update destroy ]

  # GET /admin/primary_colors or /admin/primary_colors.json
  def index
    @admin_primary_colors = PrimaryColor.all
      if params[:query].present?
        @pagy, @admin_primary_colors = pagy(PrimaryColor.where("name LIKE ?", "%#{params[:query]}%"))
      else
        @pagy, @admin_primary_colors = pagy(PrimaryColor.all)
      end
  end

  # GET /admin/primary_colors/1 or /admin/primary_colors/1.json
  def show
  end

  # GET /admin/primary_colors/new
  def new
    @admin_primary_color = PrimaryColor.new
  end

  # GET /admin/primary_colors/1/edit
  def edit
  end

  # POST /admin/primary_colors or /admin/primary_colors.json
  def create
    @admin_primary_color = PrimaryColor.new(admin_primary_color_params)

    respond_to do |format|
      if @admin_primary_color.save
        format.html { redirect_to admin_primary_color_url(@admin_primary_color), notice: "Primary color was successfully created." }
        format.json { render :show, status: :created, location: @admin_primary_color }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_primary_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/primary_colors/1 or /admin/primary_colors/1.json
  def update
    respond_to do |format|
      if @admin_primary_color.update(admin_primary_color_params)
        format.html { redirect_to admin_primary_color_url(@admin_primary_color), notice: "Primary color was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_primary_color }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_primary_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/primary_colors/1 or /admin/primary_colors/1.json
  def destroy
    @admin_primary_color.destroy!

    respond_to do |format|
      format.html { redirect_to admin_primary_colors_url, notice: "Primary color was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_primary_color
      @admin_primary_color = PrimaryColor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_primary_color_params
      params.require(:primary_color).permit(:name, :code, :price, :size,:stocks, :image, :active, :color_id, :product_id)
    end
end
