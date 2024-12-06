class PaintColorsController < ApplicationController
def show

  @paint_color = PaintColor.includes(:color, :product).find(params[:id])

end

end
