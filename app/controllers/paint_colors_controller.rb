class PaintColorsController < ApplicationController
def show
  @paint_color = PaintColor.find(params[:id])
  @color = Color.find_by(params[:color_id])
  @product = Product.find(@paint_color.product_id)
end

end
