class Color < ApplicationRecord
  has_one_attached :image 
  has_many :products
end