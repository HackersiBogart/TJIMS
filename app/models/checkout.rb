
class Checkout < ApplicationRecord
  has_one_attached :image
  validates :date_of_retrieval, presence: true

end