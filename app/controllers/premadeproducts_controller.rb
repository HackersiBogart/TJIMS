class PremadeproductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @color = @product.color
    @primary_colors = PrimaryColor.where(product_id: @product.id) # or however you're fetching paint colors


  end
end
