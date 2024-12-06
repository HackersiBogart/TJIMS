class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @color = @product.color
    @paint_colors = PaintColor.where(product_id: @product.id) # or however you're fetching paint colors


  end
  def paint_colors
    product = Product.find(params[:id])
    paint_colors = product.paint_colors.select(:id, :name)
    render json: { paint_colors: paint_colors }
  end
end