class PaintColor < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_one_attached :image
  
  # Define a variant for the attached image
  # This creates a medium-sized variant with dimensions of 250x250 pixels
  belongs_to :color
  belongs_to :product
  has_many :customer_orders


end
