class PrimaryColor < ApplicationRecord
  has_one_attached :image
  has_many :mixes
  has_many :orders # If a primary color can belong to multiple orders, this should be plural.
  has_many :mixtures
  has_many :mixture_details
  has_many :mixture_thirds


  belongs_to :color
  belongs_to :product
  has_many :products
  has_many :colors
  has_many :primary_color_stocks, dependent: :destroy

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :stocks, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :color_id, presence: true
  validates :product_id, presence: true



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
