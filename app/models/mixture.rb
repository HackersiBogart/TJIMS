class Mixture < ApplicationRecord
  belongs_to :order
  belongs_to :primary_color
  before_save :check_and_deduct_stock

  

  validates :amount, presence: true, numericality: { greater_than: 0 }
  


  private

  def check_and_deduct_stock
    if primary_color.stocks >= amount
      primary_color.deduct_stock!(amount)
    else
      errors.add(:base, "Not enough stock available")
      throw(:abort) # Prevent the record from being saved
    end
  end
end
