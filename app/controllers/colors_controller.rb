class ColorsController < ApplicationController
  def show
    @color = Color.find(params[:id])
    @products = @color.products
  end
end