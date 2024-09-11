class PaintColorsController < ApplicationController
def show
  @paint_color = PaintColor.find(params[:id])
end

end