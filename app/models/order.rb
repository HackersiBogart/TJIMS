class Order < ApplicationRecord
  belongs_to :paint_color, optional: true
  has_many :order_paint_color
end