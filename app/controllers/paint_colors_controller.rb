class PaintColorsController < ApplicationController
def show

  @paint_color = PaintColor.includes(:color, :product, :stocks)
  .find(params[:id])
end

end
