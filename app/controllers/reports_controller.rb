class ReportsController < ApplicationController
  def index
    def index
      @daily_sales = Sale.daily.total_sales
      @weekly_sales = Sale.weekly.total_sales
      @monthly_sales = Sale.monthly.total_sales
      @quarterly_sales = Sale.quarterly.total_sales
      @yearly_sales = Sale.yearly.total_sales
    end
  end
end
