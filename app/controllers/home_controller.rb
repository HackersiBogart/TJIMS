class HomeController < ApplicationController
  def index
    @main_color = Color.take(4)
  end
end