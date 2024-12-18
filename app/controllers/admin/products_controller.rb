class Admin::ProductsController < AdminController
  before_action :set_admin_product, only: %i[ show edit update destroy ]

  include Pagy::Backend
  
  # def index
  #   @pagy, @admin_products = pagy(Product.all, items: 10)
  # end
  # GET /admin/products or /admin/products.json
  def index
    @admin_products = Product.all
    if params[:query].present?
      @pagy, @admin_products = pagy(Product.where("name LIKE ?", "%#{params[:query]}%"))
    else
      @pagy, @admin_products = pagy(Product.all)
    end
  end

  def paint_colors
    product = Product.find(params[:id])
    paint_colors = product.paint_colors.select(:id, :name)
    render json: { paint_colors: paint_colors }
  end



  # GET /admin/products/1 or /admin/products/1.json
  def show
  end

  # GET /admin/products/new
  def new
    @admin_product = Product.new
  end

  # GET /admin/products/1/edit
  def edit
  end

  # POST /admin/products or /admin/products.json
  def create
    @admin_product = Product.new(admin_product_params)

    respond_to do |format|
      if @admin_product.save
        format.html { redirect_to admin_product_url(@admin_product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @admin_product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/products/1 or /admin/products/1.json
  def update
    respond_to do |format|
      if @admin_product.update(admin_product_params)
        format.html { redirect_to admin_product_url(@admin_product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/products/1 or /admin/products/1.json
  def destroy
    @admin_product.destroy!

    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_product
      @admin_product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_product_params
      params.require(:product).permit(:name, :description, :active, :color_id,:color_name, :color_code, :image, :order_id)
    end
end
  