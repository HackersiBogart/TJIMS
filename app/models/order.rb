class Order < ApplicationRecord
  belongs_to :paint_color
  has_many :order_paint_color
end