class PrimaryColor < ApplicationRecord
  has_one_attached :image
  has_many :mixes
  validates :stocks, numericality: { greater_than_or_equal_to: 0 }

  def deduct_stock(amount)
    if self.stocks >= amount
      self.stocks -= amount
      self.save
      true
    else
      false # Not enough stock to deduct
    end
  end
end
