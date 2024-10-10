class AdminController < ApplicationController
  layout 'admin'

  before_action :authenticate_admin!

  def index
    @time_range = params[:time_range] || "daily"  # Allow selection of the time range

    # Load statistics based on selected time range
    @quick_stats = load_quick_stats(@time_range)
    @revenue_by_day = load_revenue_by_time_range(@time_range)

    # Recent unfulfilled orders
    @orders = Order.where(fulfilled: false).order(created_at: :desc).take(5)

    # If the revenue by day has fewer entries (e.g., days in the week), fill in with missing days
    if @revenue_by_day.count < 7 && @time_range == "weekly"
      days_of_week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
      data_hash = @revenue_by_day.to_h

      current_day = Date.today.strftime("%A")
      current_day_index = days_of_week.index(current_day)
      next_day_index = (current_day_index + 1) % days_of_week.length

      ordered_days_with_current_last = days_of_week[next_day_index..-1] + days_of_week[0...next_day_index]

      complete_ordered_array_with_current_last = ordered_days_with_current_last.map { |day| [day, data_hash.fetch(day, 0)] }
      @revenue_by_day = complete_ordered_array_with_current_last
    end
  end

  private

  # Method to load quick statistics for different time ranges
  def load_quick_stats(time_range)
    case time_range
    when "daily"
      {
        sales: Order.where(created_at: Time.zone.today.all_day).count,
        revenue: Order.where(created_at: Time.zone.today.all_day).sum(:total)&.round(),
        avg_sale: Order.where(created_at: Time.zone.today.all_day).average(:total)&.round(),
        per_sale: OrderPaintColor.joins(:order).where(orders: { created_at: Time.zone.today.all_day })&.average(:quantity)
      }
    when "weekly"
      {
        sales: Order.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day).count,
        revenue: Order.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day).sum(:total)&.round(),
        avg_sale: Order.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day).average(:total)&.round(),
        per_sale: OrderPaintColor.joins(:order).where(orders: { created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day })&.average(:quantity)
      }
    when "monthly"
      {
        sales: Order.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day).count,
        revenue: Order.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day).sum(:total)&.round(),
        avg_sale: Order.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day).average(:total)&.round(),
        per_sale: OrderPaintColor.joins(:order).where(orders: { created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day })&.average(:quantity)
      }
    when "quarterly"
      {
        sales: Order.where(created_at: 3.months.ago.beginning_of_day..Time.zone.now.end_of_day).count,
        revenue: Order.where(created_at: 3.months.ago.beginning_of_day..Time.zone.now.end_of_day).sum(:total)&.round(),
        avg_sale: Order.where(created_at: 3.months.ago.beginning_of_day..Time.zone.now.end_of_day).average(:total)&.round(),
        per_sale: OrderPaintColor.joins(:order).where(orders: { created_at: 3.months.ago.beginning_of_day..Time.zone.now.end_of_day })&.average(:quantity)
      }
    when "yearly"
      {
        sales: Order.where(created_at: 1.year.ago.beginning_of_day..Time.zone.now.end_of_day).count,
        revenue: Order.where(created_at: 1.year.ago.beginning_of_day..Time.zone.now.end_of_day).sum(:total)&.round(),
        avg_sale: Order.where(created_at: 1.year.ago.beginning_of_day..Time.zone.now.end_of_day).average(:total)&.round(),
        per_sale: OrderPaintColor.joins(:order).where(orders: { created_at: 1.year.ago.beginning_of_day..Time.zone.now.end_of_day })&.average(:quantity)
      }
    else
      {}
    end
  end

  # Method to load revenue data for the chart by time range
  def load_revenue_by_time_range(time_range)
    case time_range
    when "daily"
      Order.group_by_day(:created_at).sum(:total)
    when "weekly"
      Order.group_by_week(:created_at).sum(:total)
    when "monthly"
      Order.group_by_month(:created_at).sum(:total)
    when "quarterly"
      Order.group_by_quarter(:created_at).sum(:total)
    when "yearly"
      Order.group_by_year(:created_at).sum(:total)
    end
  end
end
