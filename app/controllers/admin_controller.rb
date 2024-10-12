class AdminController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!

  def index
    @time_range = params[:time_range] || "daily"

    # Load statistics based on selected time range
    @quick_stats = load_quick_stats(@time_range)
    @revenue_by_day = load_revenue_by_time_range(@time_range)

    # Load recent unfulfilled orders
    @orders = fetch_recent_unfulfilled_orders

    # Complete revenue data if needed for weekly and other time ranges
    complete_revenue_data_if_needed
  end

  private

  # Method to load quick statistics for different time ranges
  def load_quick_stats(time_range)
    range = time_range_to_range(time_range)
    {
      sales: Order.where(created_at: range).count,
      revenue: Order.where(created_at: range).sum(:total).round,
      avg_sale: Order.where(created_at: range).average(:total)&.round,
      per_sale: OrderPaintColor.joins(:order).where(orders: { created_at: range }).average(:quantity)
    }
  end

  # Method to load revenue data for the chart by time range
  def load_revenue_by_time_range(time_range)
    case time_range
    when "daily"
      # Group by hour for the current day
      Order.where(created_at: Time.zone.today.all_day)
           .group_by_hour(:created_at, format: "%H:00")
           .sum(:total)
    when "weekly"
      # Group by day of the current week (Sunday to Saturday)
      Order.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day)
           .group_by_day(:created_at, format: "%A")
           .sum(:total)
    when "monthly"
      # Group by day of the month
      Order.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day)
           .group_by_day(:created_at)
           .sum(:total)
    when "yearly"
      # Group by month of the year
      Order.where(created_at: 1.year.ago.beginning_of_day..Time.zone.now.end_of_day)
           .group_by_month(:created_at, format: "%B")
           .sum(:total)
    else
      # Default to daily grouping
      Order.group_by_day(:created_at).sum(:total)
    end
  end
  

  # Fetch recent unfulfilled orders
  def fetch_recent_unfulfilled_orders
    Order.where(fulfilled: false).order(created_at: :desc).limit(5)
  end

  # Complete revenue data for time ranges (weekly, monthly, etc.)
  def complete_revenue_data_if_needed
    if @revenue_by_day.count < expected_data_points(@time_range)
      fill_in_missing_data
    end
  end

  # Helper to fill in missing data points for revenue
  def fill_in_missing_data
    case @time_range
    when "daily"
      fill_in_missing_hours(24) # 24 hours in a day
    when "weekly"
      fill_in_missing_weekdays(7) # 7 days in a week
    when "monthly"
      fill_in_missing_month_days
    when "yearly"
      fill_in_missing_months(12) # 12 months in a year
    end
  end

  # Helper to determine the expected number of data points
  def expected_data_points(time_range)
    case time_range
    when "daily" then 1
    when "weekly" then 7
    when "monthly" then 30
    when "yearly" then 12
    else 1
    end
  end

  # Fills in missing days for weekly/monthly data
  def fill_in_missing_weekdays(days_count)
    weekdays = Date::DAYNAMES # ["Sunday", "Monday", ..., "Saturday"]
    @revenue_by_day = weekdays.map { |day| [day, @revenue_by_day.fetch(day, 0)] }
  end
  
  # Fill in missing days for monthly data
  def fill_in_missing_month_days
    days_in_month = (Date.today.beginning_of_month..Date.today.end_of_month).map { |d| d.day }
    @revenue_by_day = days_in_month.map { |day| [day.to_s, @revenue_by_day.fetch(day.to_s, 0)] }
  end
  
  # Fill in missing hours for daily data
  def fill_in_missing_hours(hour_count)
    hours = (0...hour_count).map { |i| format("%02d:00", i) }
    @revenue_by_day = hours.map { |hour| [hour, @revenue_by_day.fetch(hour, 0)] }
  end
  
  # Fill in missing months for yearly data
  def fill_in_missing_months(month_count)
    months = Date::MONTHNAMES[1..12] # ["January", ..., "December"]
    @revenue_by_day = months.map { |month| [month, @revenue_by_day.fetch(month, 0)] }
  end

  # Convert time range string to a range object
  def time_range_to_range(time_range)
    case time_range
    when "daily"
      Time.zone.today.all_day
    when "weekly"
      1.week.ago.beginning_of_day..Time.zone.now.end_of_day
    when "monthly"
      1.month.ago.beginning_of_day..Time.zone.now.end_of_day
    when "yearly"
      1.year.ago.beginning_of_day..Time.zone.now.end_of_day
    else
      Time.zone.today.all_day
    end
  end
end
