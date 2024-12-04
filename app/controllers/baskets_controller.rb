class BasketsController < ApplicationController
  before_action :set_basket

  def show
    @basket_items = @basket.basket_items.includes(:thing)
  end

  def add_item
    thing = Thing.find(params[:thing_id])
    item = @cart.cart_items.find_or_initialize_by(thing: thing)
    item.quantity += params[:quantity].to_i
    item.save
    redirect_to basket_path
  end

  def remove_item
    @basket.basket_items.find(params[:id]).destroy
    redirect_to basket_path
  end

  private

  def set_basket
    @basket = Basket.find_or_create_by(id: session[:basket_id]) || Basket.create
    session[:basket_id] = @basket.id
  end
end
