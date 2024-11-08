class OrderPaintColor < ApplicationRecord
  belongs_to :paint_color
  belongs_to :order
end
