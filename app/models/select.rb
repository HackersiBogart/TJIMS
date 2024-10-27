class Select < ApplicationRecord
  has_many :products
  belongs_to :color
end
