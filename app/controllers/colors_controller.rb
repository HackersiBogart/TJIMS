class ColorsController < ApplicationController

  def products
    color = Color.find(params[:id])
    products = color.products
    render json: { products: products }
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