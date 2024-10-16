class Color < ApplicationRecord
  has_one_attached :image 
  has_many :products
  has_many :orders
  belongs_to :paint_color


end