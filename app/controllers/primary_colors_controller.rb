class PrimaryColorsController < ApplicationController
  def show
    @primary_color = PrimaryColor.find(params[:id])
    @color = Color.find_by(params[:color_id])
    @product = Product.find(@primary_color.product_id)

  end
  
end

  
  