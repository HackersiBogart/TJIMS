class PrimaryColor < ApplicationRecord
  has_one_attached :image
  has_many :mixes
  has_many :mixtures
  validates :stocks, numericality: { greater_than_or_equal_to: 0 }

  def deduct_stock!(amount)
    if stocks >= amount
      self.stocks -= amount
      save!
    else
      errors.add(:stocks, "Not enough stock available")
      raise ActiveRecord::RecordInvalid, self
    end
  end
end
