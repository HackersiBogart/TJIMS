class MixtureThird < ApplicationRecord
  belongs_to :mixture
  belongs_to :primary_color
  validates :mixture_id, presence: true
  validates :order_id, presence: true, numericality: { only_integer: true }
  validates :primary_color_id, presence: true, numericality: { only_integer: true }
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
