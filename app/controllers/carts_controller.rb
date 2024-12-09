class CartsController < ApplicationController
  def show
   
    @paint_color = PaintColor.find_by(id: params[:id])
    @color = Color.find_by(id: params[:id])
    @product = Product.find_by(id: params[:id])

  end

end