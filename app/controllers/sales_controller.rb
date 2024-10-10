class SalesController < ApplicationController
  def index
    @colors = Color.includes(:orders) # Assuming Brand model is related to Order
    @products = Product.includes(:orders) # Assuming Product model is related to Order
    @paint_colors = PaintColor.includes(:orders) # Assuming PaintColor model is related to Order
    @primary_colors = PrimaryColor.includes(:orders) # Assuming PrimaryColor model is related to Order

    @sales_data = {
      colors: @colors.map { |color| [color.name, color.orders.sum(:total)] }.to_h,
      products: @products.map { |product| [product.name, product.orders.sum(:total)] }.to_h,
      paint_colors: @paint_colors.map { |paint_color| [paint_color.name, paint_color.orders.sum(:total)] }.to_h,
      primary_colors: @primary_colors.map { |primary_color| [primary_color.color_name, primary_color.orders.sum(:total)] }.to_h,
    }
  end
end
