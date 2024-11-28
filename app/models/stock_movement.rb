class StockMovement < ApplicationRecord
  belongs_to :product
  belongs_to :primary_color
  belongs_to :paint_color
  belongs_to :order
  belongs_to :color
  has_many :products
  has_many :primary_colors
  has_many :paint_colors
  has_many :orders
  has_many :colors


  enum movement_type: { add: 'add', deduct: 'deduct' }

  validates :unit, presence: true, inclusion: { in: ['liter', 'gallon'], message: "%{value} is not a valid unit" }
  validates :size, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0, message: "must be greater than 0" }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, message: "must be a positive number" }
end


