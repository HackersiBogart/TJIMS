class PrimaryColor < ApplicationRecord
  has_one_attached :image
  has_many :mixes
  has_many :orders
  has_many :mixtures
  has_many :mixture_details
  has_many :mixture_thirds
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

  def deduct_stock_vone!(amount)
    if stocks >= amount
      self.stocks -= amount
      save!
    else
      errors.add(:stocks, "Not enough stock available")
      raise ActiveRecord::RecordInvalid, self
    end
  end

  def deduct_stock_vtwo!(amount)
    if stocks >= amount
      self.stocks -= amount
      save!
    else
      errors.add(:stocks, "Not enough stock available")
      raise ActiveRecord::RecordInvalid, self
    end
  end
end
