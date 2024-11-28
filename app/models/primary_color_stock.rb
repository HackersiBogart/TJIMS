class PrimaryColorStock < ApplicationRecord
  belongs_to :primary_color

  validates :size, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
