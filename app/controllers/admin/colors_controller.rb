class Admin::ColorsController < AdminController
  before_action :set_admin_color, only: %i[ show edit update destroy ]

  # GET /admin/colors or /admin/colors.json
  def index
    @admin_colors = Color.all
  end

  # GET /admin/colors/1 or /admin/colors/1.json
  def show
  end

  # GET /admin/colors/new
  def new
    @admin_color = Color.new
  end

  # GET /admin/colors/1/edit
  def edit
  end

  # POST /admin/colors or /admin/colors.json
  def create
    @admin_color = Color.new(admin_color_params)

    respond_to do |format|
      if @admin_color.save
        format.html { redirect_to admin_color_url(@admin_color), notice: "Color was successfully created." }
        format.json { render :show, status: :created, location: @admin_color }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/colors/1 or /admin/colors/1.json
  def update
    respond_to do |format|
      if @admin_color.update(admin_color_params)
        format.html { redirect_to admin_color_url(@admin_color), notice: "Color was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_color }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_color.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/colors/1 or /admin/colors/1.json
  def destroy
    @admin_color.destroy!

    respond_to do |format|
      format.html { redirect_to admin_colors_url, notice: "Color was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_color
      @admin_color = Color.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_color_params
      params.require(:color).permit(:name, :code, :size, :quantity, :image)
    end
end
