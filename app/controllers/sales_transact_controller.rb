class SalesTransactController < ApplicationController
  def new
    @sales_transact = SalesTransact.new
    @basket = Basket.find(session[:basket_id])
  end
  
  def create
    @basket = Basket.find(session[:basket_id])
    @sales_transact = SalesTransact.new(sales_transact_params)
    @sales_transact.total = @basket.basket_items.sum { |item| item.quantity * item.thing.price }
  
    if @sales_transact.save
      @basket.basket_items.each do |item|
        @sales_transact.sales_transact_items.create(
          thing: item.thing,
          quantity: item.quantity,
          price: item.thing.price
        )
      end
      @basket.destroy
      session[:basket_id] = nil
      redirect_to sales_transact_path(@sales_transact), notice: 'Transaction placed successfully!'
    else
      render :new
    end
  end
  
  def show
    @sales_transact = SalesTransact.find(params[:id])
  end
  
  private
  
  def sales_transact_params
    params.require(:sales_transact).permit(:customer_name, :customer_email, :phone_number)
  end
  
end
