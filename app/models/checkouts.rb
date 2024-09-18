
class Checkout < ApplicationRecord
  has_one_attached :receipt_image
  validates :date_of_retrieval, presence: true

end