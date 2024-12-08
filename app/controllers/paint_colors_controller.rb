class PaintColorsController < ApplicationController
def show

  @paint_color = PaintColor.find(params[:id])
  # Ensure these associations exist
  @paint_color.color_id ||= @paint_color.color&.id
  @paint_color.product_id ||= @paint_color.product&.id

  logger.debug "Color ID: #{@paint_color.color_id}"
  logger.debug "Product ID: #{@paint_color.product_id}"

end

end
