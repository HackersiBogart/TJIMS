class Admin::MixtureThirdsController < ApplicationController
  before_action :set_admin_mixture_third, only: %i[ show edit update destroy ]

  # GET /admin/mixture_thirds or /admin/mixture_thirds.json
  def index
    @admin_mixture_thirds = MixtureThird.all
  end

  # GET /admin/mixture_thirds/1 or /admin/mixture_thirds/1.json
  def show
  end

  # GET /admin/mixture_thirds/new
  def new
    @admin_mixture_third = MixtureThird.new
  end

  # GET /admin/mixture_thirds/1/edit
  def edit
  end

  # POST /admin/mixture_thirds or /admin/mixture_thirds.json
  def create
    @admin_mixture_third = MixtureThird.new(admin_mixture_third_params)

    respond_to do |format|
      if @admin_mixture_third.save
        format.html { redirect_to admin_mixture_third_url(@admin_mixture_third), notice: "Mixture third was successfully created." }
        format.json { render :show, status: :created, location: @admin_mixture_third }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_mixture_third.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/mixture_thirds/1 or /admin/mixture_thirds/1.json
  def update
    respond_to do |format|
      if @admin_mixture_third.update(admin_mixture_third_params)
        format.html { redirect_to admin_mixture_third_url(@admin_mixture_third), notice: "Mixture third was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_mixture_third }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_mixture_third.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/mixture_thirds/1 or /admin/mixture_thirds/1.json
  def destroy
    @admin_mixture_third.destroy!

    respond_to do |format|
      format.html { redirect_to admin_mixture_thirds_url, notice: "Mixture third was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_mixture_third
      @admin_mixture_third = MixtureThird.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_mixture_third_params
      params.require(:admin_mixture_third).permit(:mixture_id, :order_id, :primary_color_id, :amount)
    end
end
