class CartsController < ApplicationController
  def show
    @paint_color = PaintColor.includes(:color, :product).find_by(id: params[:id])

    if @paint_color.nil?
      render json: { error: "Paint color not found" }, status: :not_found 
    end

    @color = @paint_color.color
    @product = @paint_color.product

    if @paint_color.color_id.nil? && @color.present?
      @paint_color.update(color_id: @color.id)
    end

    if @paint_color.product_id.nil? && @product.present?
      @paint_color.update(product_id: @product.id)
    end

    respond_to do |format|
      format.html # Default to rendering HTML
      format.json { render json: { paint_color: @paint_color, color: @color, product: @product } }
    end
  end
end
