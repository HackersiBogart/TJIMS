class ColorsController < ApplicationController


  def index
    @paint_colors = Color.all # Fetch all colors to display on the index page
  end

  def show
    @color = Color.find(params[:id])
    @products = @color.products
  end
end