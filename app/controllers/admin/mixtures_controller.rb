class Admin::MixturesController < AdminController
  before_action :set_admin_mixture, only: %i[ show edit update destroy ]
  before_action :set_order, only: :change_fulfilled

  # GET /admin/mixtures or /admin/mixtures.json
  def index

    @admin_mixtures = Mixture.all
    if params[:query].present?
      @pagy, @admin_mixtures = pagy(Mixture.where("name LIKE ?", "%#{params[:query]}%"))
    else
      @pagy, @admin_mixtures = pagy(Mixture.all)
    end
  end

  # GET /admin/mixtures/1 or /admin/mixtures/1.json
  def show
  end

  # GET /admin/mixtures/new
  def new
    @order = Order.find(params[:order_id]) if params[:order_id].present?
   
    @admin_mixture = Mixture.new
    @admin_mixture.mixture_details.build
    @admin_mixture.mixture_thirds.build
   
  end

  # GET /admin/mixtures/1/edit
  def edit
  end

  # POST /admin/mixtures or /admin/mixtures.json
  def create
    @admin_mixture = Mixture.new(admin_mixture_params)

    respond_to do |format|
      if @admin_mixture.save
        format.html { redirect_to admin_mixture_url(@admin_mixture), notice: "Mixture was successfully created." }
        format.json { render :show, status: :created, location: @admin_mixture }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_mixture.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_fulfilled
    # Change the order's fulfillment status or any other field as needed
    if @admin_order.update(name: params[:name]) # Update to the exact fields you need
      # Send an email notification upon successful fulfillment change
      OrderMailer.fulfillment_email(@admin_order).deliver_now
      redirect_to admin_orders_path, notice: 'Fulfillment status updated and email sent successfully.'
    else
      # Handle the case where the update fails
      redirect_to admin_order_path(@admin_order), alert: 'Failed to update order fulfillment status.'
    end
  end

  

  

  # PATCH/PUT /admin/mixtures/1 or /admin/mixtures/1.json
  def update
    respond_to do |format|
      if @admin_mixture.update(admin_mixture_params)
        format.html { redirect_to admin_mixture_url(@admin_mixture), notice: "Mixture was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_mixture }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_mixture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/mixtures/1 or /admin/mixtures/1.json
  def destroy
    @admin_mixture.destroy!

    respond_to do |format|
      format.html { redirect_to admin_mixtures_url, notice: "Mixture was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_mixture
      @admin_mixture = Mixture.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_mixture_params
      params.require(:mixture).permit(:order_id, :primary_color_id, :amount, mixture_details_attributes: %i[
        id
        order_id
        primary_color_id
        amount
        _destroy
      ], mixture_thirds_attributes: %i[
        id
        order_id
        primary_color_id
        amount
        _destroy])

    end
end
