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

  def load_revenue_by_time_range(time_range)
    case time_range
    when "daily"
      revenue_data = Order.where(fulfilled: true, updated_at: Time.zone.today.all_day)
                           .group_by_hour(:updated_at, format: "%I %p") # Format for AM/PM
                           .sum(:order_total)
      fill_in_missing_hours(revenue_data, 24) # 24 hours in a day

    when "weekly"
      revenue_data = Order.where(fulfilled: true, updated_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day)
                           .group_by_day(:updated_at, format: "%A")
                           .sum(:order_total)
      fill_in_missing_weekdays(revenue_data, 7)

    when "monthly"
      revenue_data = Order.where(fulfilled: true, updated_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day)
                           .group_by_week(:updated_at, format: "Week %U")
                           .sum(:order_total)
      fill_in_missing_weeks(revenue_data, 5)

    when "yearly"
      revenue_data = Order.where(fulfilled: true, updated_at: 1.year.ago.beginning_of_day..Time.zone.now.end_of_day)
                           .group_by_month(:updated_at, format: "%B")
                           .sum(:order_total)
      fill_in_missing_months(revenue_data, 12)
    end
  end

  # Fill in missing hours with AM/PM labels
  def fill_in_missing_hours(revenue_data, count)
    hours = (0...count).map { |i| Time.zone.now.beginning_of_day + i.hours }
    hours.map do |hour|
      formatted_hour = hour.strftime("%I %p") # Format hour as AM/PM
      [formatted_hour, revenue_data.fetch(formatted_hour, 0)]
    end
  end

  def fill_in_missing_weekdays(revenue_data, count)
    weekdays = (0...count).map { |i| (Date.today - (count - i - 1).days).strftime("%A") }
    weekdays.map { |weekday| [weekday, revenue_data.fetch(weekday, 0)] }
  end

  def fill_in_missing_weeks(revenue_data, count)
    weeks = (0...count).map { |i| "Week #{(Date.today.cweek - count + i + 1)}" }
    weeks.map { |week| [week, revenue_data.fetch(week, 0)] }
  end

  def fill_in_missing_months(revenue_data, count)
    months = (0...count).map { |i| (Date.today - (count - i - 1).months).strftime("%B") }
    months.map { |month| [month, revenue_data.fetch(month, 0)] }
  end

  def fetch_recent_unfulfilled_orders
    Order.includes(:order_paint_color)
         .where(fulfilled: false)
         .limit(5)
         .order(updated_at: :desc)
  end

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

  def complete_revenue_data_if_needed
    case @time_range
    when "daily"
      @revenue_by_day = fill_in_missing_hours(@revenue_by_day, 24)
    when "weekly"
      @revenue_by_day = fill_in_missing_weekdays(@revenue_by_day, 7)
    when "monthly"
      @revenue_by_day = fill_in_missing_weeks(@revenue_by_day, 5)
    when "yearly"
      @revenue_by_day = fill_in_missing_months(@revenue_by_day, 12)
    end
  end
end
