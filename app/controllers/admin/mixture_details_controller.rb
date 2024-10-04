class Admin::MixtureDetailsController < ApplicationController
  before_action :set_admin_mixture_detail, only: %i[ show edit update destroy ]

  # GET /admin/mixture_details or /admin/mixture_details.json
  def index
    @admin_mixture_details =MixtureDetail.all
  end

  # GET /admin/mixture_details/1 or /admin/mixture_details/1.json
  def show
  end

  # GET /admin/mixture_details/new
  def new
    @admin_mixture_detail =MixtureDetail.new
  end

  # GET /admin/mixture_details/1/edit
  def edit
  end

  # POST /admin/mixture_details or /admin/mixture_details.json
  def create
    @admin_mixture_detail = MixtureDetail.new(admin_mixture_detail_params)

    respond_to do |format|
      if @admin_mixture_detail.save
        format.html { redirect_to admin_mixture_detail_url(@admin_mixture_detail), notice: "Mixture detail was successfully created." }
        format.json { render :show, status: :created, location: @admin_mixture_detail }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_mixture_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/mixture_details/1 or /admin/mixture_details/1.json
  def update
    respond_to do |format|
      if @admin_mixture_detail.update(admin_mixture_detail_params)
        format.html { redirect_to admin_mixture_detail_url(@admin_mixture_detail), notice: "Mixture detail was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_mixture_detail }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_mixture_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/mixture_details/1 or /admin/mixture_details/1.json
  def destroy
    @admin_mixture_detail.destroy!

    respond_to do |format|
      format.html { redirect_to admin_mixture_details_url, notice: "Mixture detail was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_mixture_detail
      @admin_mixture_detail = MixtureDetail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_mixture_detail_params
      params.require(:admin_mixture_detail).permit(:mixture_id, :order_id, :primary_color_id, :amount)
    end
end
