class Sale < ApplicationRecord
    # Scope for daily sales
    scope :daily, -> { where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }

    # Scope for weekly sales
    scope :weekly, -> { where(created_at: Time.zone.now.beginning_of_week..Time.zone.now.end_of_week) }
  
    # Scope for monthly sales
    scope :monthly, -> { where(created_at: Time.zone.now.beginning_of_month..Time.zone.now.end_of_month) }
  
    # Scope for quarterly sales
    scope :quarterly, -> {
      where(created_at: (Time.zone.now.beginning_of_quarter..Time.zone.now.end_of_quarter))
    }
  
    # Scope for yearly sales
    scope :yearly, -> { where(created_at: Time.zone.now.beginning_of_year..Time.zone.now.end_of_year) }
  
    # Optional: To calculate the total sales in a period
    def self.total_sales
      sum(:total)
    end
end
