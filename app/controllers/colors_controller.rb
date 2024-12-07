class ColorsController < ApplicationController

  def products
    color = Color.find(params[:id])
    product = color.product # Retrieves the associated Product object
    if product
      render json: { product: { id: product.id, name: product.name, image: product.image } }
    else
      render json: { product: nil }
    end
  end
  def index
    @paint_colors = Color.all # Fetch all colors to display on the index page
    @color = Color.find(params[:id])
    @products = @color.products
  end

  def show
    @color = Color.find(params[:id])
    @products = @color.products
  end
end