class PaintColor < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_one_attached :image
  
  # Define a variant for the attached image
  # This creates a medium-sized variant with dimensions of 250x250 pixels
  belongs_to :color
  belongs_to :product
  has_many :customer_orders

  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :code, presence: true, length: { maximum: 20 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0, message: "must be a positive number or zero" }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0, message: "must be a positive number or zero" }
  validates :color_id, presence: true
  validates :product_id, presence: true


end
