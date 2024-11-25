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
      sales: Order.where(fulfilled: true, updated_at: range).count,
      revenue: Order.where(fulfilled: true, updated_at: range).sum(:order_total).round,
      avg_sale: Order.where(fulfilled: true, updated_at: range).average(:order_total)&.round,
      per_sale: OrderPaintColor.joins(:order).where(orders: { updated_at: range }).average(:quantity)
    }
  end

  # Method to load revenue data for the chart by time range
  def load_revenue_by_time_range(time_range)
    case time_range
    when "daily"
      # Group by hour for the current day
      revenue_data = Order.where(fulfilled: true, updated_at: Time.zone.today.all_day)
                           .group_by_hour(:updated_at, format: "%H")
                           .sum(:order_total)
      format_revenue_data(revenue_data, 24, :hour)
  
    when "weekly"
      # Group by day of the current week (Sunday to Saturday)
      revenue_data = Order.where(fulfilled: true, updated_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day)
                           .group_by_day(:updated_at, format: "%A")
                           .sum(:order_total)
      format_revenue_data(revenue_data, 7, :day)
  
    when "monthly"
      # Group by week of the month
      revenue_data = Order.where(fulfilled: true, updated_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day)
                           .group_by_week(:updated_at, format: "%U")  # Group by week number (0-53)
                           .sum(:order_total)
      format_revenue_data(revenue_data, 5, :week)  # 5 weeks is typical for a month, can vary
  
    when "yearly"
      # Group by month of the year
      revenue_data = Order.where(fulfilled: true, updated_at: 1.year.ago.beginning_of_day..Time.zone.now.end_of_day)
                           .group_by_month(:updated_at, format: "%B")
                           .sum(:order_total)
      format_revenue_data(revenue_data, 12, :month)
  
    else
      # Default to daily grouping
      Order.group_by_day(:updated_at).sum(:order_total)
    end
  end
  

  # Helper to format revenue data for different time ranges
  def format_revenue_data(revenue_data, expected_count, period_type)
    # Fill in missing periods (e.g., hours for daily, weekdays for weekly, etc.)
    formatted_data = case period_type
                     when :hour then fill_in_missing_hours(revenue_data, 24) # 24 hours in a day
                     when :day then fill_in_missing_weekdays(revenue_data, 7) # 7 days in a week
                     when :month then fill_in_missing_months(revenue_data, 12) # 12 months in a year
                     when :week then fill_in_missing_weeks(revenue_data, 5) # 5 weeks in a month (could be 4-5 depending on the month)
                     else
                       []
                     end
    formatted_data
  end

  

  # Fill in missing data for different time ranges
  def fill_in_missing_hours(revenue_data, count)
    hours = (0...count).map { |i| format("%02d", i) }
    hours.map { |hour| [hour, revenue_data.fetch(hour, 0)] }
  end

  def fill_in_missing_weekdays(revenue_data, count)
    weekdays = Date::DAYNAMES # ["Sunday", "Monday", ..., "Saturday"]
    weekdays.map { |day| [day, revenue_data.fetch(day, 0)] }
  end

  def fill_in_missing_months(revenue_data, count)
    months = Date::MONTHNAMES[1..12] # ["January", ..., "December"]
    months.map { |month| [month, revenue_data.fetch(month, 0)] }
  end

  # Fetch recent unfulfilled orders
  def fetch_recent_unfulfilled_orders
    Order.where(fulfilled: false).order(created_at: :desc).limit(5)
  end

  def fill_in_missing_weeks(revenue_data, count)
    # Generate weeks (1 through 5, or dynamically calculate the number of weeks in the month)
    weeks = (1..count).map { |i| "Week #{i}" }
    
    # Ensure revenue_data is a hash if it's not already
    revenue_data = revenue_data.to_h unless revenue_data.is_a?(Hash)
  
    # Fill in the missing weeks, setting their revenue to 0 if not already present
    weeks.map { |week| [week, revenue_data.fetch(week, 0)] }
  end
  
  
  

  def complete_revenue_data_if_needed
    if @revenue_by_day.count < expected_data_points(@time_range)
      case @time_range
      when "daily"
        fill_in_missing_hours(@revenue_by_day, 24) # 24 hours in a day
      when "weekly"
        fill_in_missing_weekdays(@revenue_by_day, 7) # 7 days in a week
      when "monthly"
        fill_in_missing_weeks(@revenue_by_day, 5) # 5 weeks in a month
      when "yearly"
        fill_in_missing_months(@revenue_by_day, 12) # 12 months in a year
      end
    end
  end



  def fill_in_missing_data
    case @time_range
    when "daily"
      fill_in_missing_hours(@revenue_by_day, 24) # 24 hours in a day
    when "weekly"
      fill_in_missing_weekdays(@revenue_by_day, 7) # 7 days in a week
    when "monthly"
      fill_in_missing_month_days(@revenue_by_day) # Fill missing days in the month
    when "yearly"
      fill_in_missing_months(@revenue_by_day, 12) # 12 months in a year
    end
  end


  def complete_revenue_data_if_needed
    if @revenue_by_day.count < expected_data_points(@time_range)
      fill_in_missing_data
    end
  end

  # Helper to determine the expected number of data points
  def expected_data_points(time_range)
    case time_range
    when "daily" then 24 # 24 hours in a day
    when "weekly" then 7  # 7 days in a week
    when "monthly" then 5  # Up to 5 weeks in a month
    when "yearly" then 12 # 12 months in a year
    else 1
    end
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
