class CartsController < ApplicationController
  def show
    @paint_color = PaintColor.find_by(id: params[:id]) # Find the paint color by ID

    if @paint_color
      @color = @paint_color.color    # Retrieve associated color
      @product = @paint_color.product # Retrieve associated product
    else
      flash[:error] = "Paint color not found"
      redirect_to root_path # Or any fallback path
    end
  end
end
