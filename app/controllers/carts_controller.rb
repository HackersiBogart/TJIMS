class CartsController < ApplicationController
  def show
    @paint_color = PaintColor.includes(:color, :product).find_by(id: params[:id])

    # Handle case where PaintColor is not found
    if @paint_color.nil?
      flash[:error] = "Paint color not found."
    end

    # Ensure color and product associations exist
    @color = @paint_color.color
    @product = @paint_color.product

    # Update color_id and product_id if missing
    if @paint_color.color_id.nil? && @color.present?
      @paint_color.update(color_id: @color.id)
    end

    if @paint_color.product_id.nil? && @product.present?
      @paint_color.update(product_id: @product.id)
    end
  end
end
