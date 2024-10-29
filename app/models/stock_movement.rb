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
end


