class Color < ApplicationRecord
  has_one_attached :image 
  has_many :products
  has_many :orders
  has_many :select
  has_many :paint_colors
  has_many :primary_colors



end