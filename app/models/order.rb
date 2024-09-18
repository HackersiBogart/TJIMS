class Order < ApplicationRecord
  belongs_to :paint_color, optional: true
  has_many :order_paint_color


  has_one_attached :receipt_image # Assuming Active Storage is set up for receipt images

  validates :name, :customer_email, :phone_number, :total, :reference_number, presence: true

  

end