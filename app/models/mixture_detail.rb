class MixtureDetail < ApplicationRecord
  belongs_to :mixture
  belongs_to :primary_color
  validates :mixture_id, presence: true
  validates :order_id, presence: true, numericality: { only_integer: true }
  

end
