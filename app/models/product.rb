class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :color
  has_many :paint_colors
  has_many :orders
  belongs_to :order
  
end