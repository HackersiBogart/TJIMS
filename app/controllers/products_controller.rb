class ProductsController < ApplicationController
  def show
    @product = Product.find(params[:id])
    @color = @product.color
    @paint_colors = PaintColor.where(product_id: @product.id) # or however you're fetching paint colors


  end
  def paint_colors
    product = Product.find(params[:id])
    paint_colors = product.paint_colors
    render json: { paint_colors: paint_colors }
    if paint_color
      render json: { paint_color: { id: paint_color.id, name: paint_color.name, image: paint_color.image } }
    else
      render json: { paint_color: nil }
    end
  end

end