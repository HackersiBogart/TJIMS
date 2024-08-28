class PaintColor < ApplicationRecord
  has_many :stocks, dependent: :destroy
  has_one_attached :image
  belongs_to :color
  has_many :orders
  has_many :order_paint_color
end