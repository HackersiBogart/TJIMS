class CartsController < ApplicationController
  def show
    @paint_color = PaintColor.includes(:color, :product).find(params[:id]) # Eager load associations
  
    # Ensure associated IDs are set
    if @paint_color.color_id.nil? && @paint_color.color.present?
      @paint_color.color_id = @paint_color.color.id
    end
  
    if @paint_color.product_id.nil? && @paint_color.product.present?
      @paint_color.product_id = @paint_color.product.id
    end
end
