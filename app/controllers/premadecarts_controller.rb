class PremadecartsController < ApplicationController
  def show
   
    @primary_color = PrimaryColor.find_by(id: params[:id])
    @color = Color.find_by(params[:color_id])
    @product = Product.find_by(params[:product_id])

  end

end