class PremadeController < ApplicationController
  def index
    @main_color = Color.all
  end
end
