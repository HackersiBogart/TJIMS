class Admin::MixController < AdminController
  def index
    @mixes = Mix.all
    @paint_colors = PaintColor.all # Adjust this according to your model
    @primary_colors = PrimaryColor.all # Adjust this according to your model
    @orders = Order.all # Adjust this according to your model
  end


    def deduct_stock
      # Iterate over each selected primary color and its amount from the form submission
      params[:admin_primary_color][:colors_attributes].each do |_index, color_data|
        primary_color_id = color_data[:primary_color_id]
        amount_to_deduct = color_data[:amount].to_f
  
        # Find the corresponding primary color
        primary_color = PrimaryColor.find(primary_color_id)
  
        # Deduct stock using the deduct_stock method from the PrimaryColor model
        unless primary_color.deduct_stock(amount_to_deduct)
          flash[:alert] = "Not enough stock for #{primary_color.color_name}."
          redirect_to mix_index_path and return # If stock is insufficient, redirect with error
        end
      end
  
      # Success message after deducting stock for all selected colors
      flash[:notice] = "Stock deducted successfully."
      redirect_to mix_create_path
    end



  def new
    @mix = Mix.new
    @paint_colors = PaintColor.all
    @primary_colors = PrimaryColor.all
    @admin_primary_color = PrimaryColor.new
    @orders = Order.all 
  end

 

  def create
    order_id = params[:order_id] # The selected order ID
    primary_colors_data = params[:primary_colors] # This should be populated with the correct data
  
    if primary_colors_data.nil?
      flash[:alert] = "No primary colors selected."
      redirect_to admin_mix_index_path and return
    end
  
    primary_colors_data.each do |_, color_data|
      primary_color_id = color_data[:primary_color_id]
      amount_to_deduct = color_data[:amount].to_f
  
      primary_color = PrimaryColor.find(primary_color_id)
  
      unless primary_color.deduct_stock(amount_to_deduct)
        flash[:alert] = "Not enough stock for #{primary_color.color_name}."
        redirect_to admin_mix_index_path and return
      end
  
      Mix.create(order_id: order_id, primary_color: primary_color, amount: amount_to_deduct)
    end
  
    flash[:notice] = "Mix created and stock deducted successfully!"
    redirect_to admin_mix_index_path
  end
  
  

  
  private

  def mix_params
    params.require(:mix).permit(:primary_color_id, :amount, :order_id, :stocks)
  end
end
