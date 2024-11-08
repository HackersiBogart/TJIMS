class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @color = @product.color
    @paint_colors = PaintColor.where(product_id: @product.id) # or however you're fetching paint colors


  end
end