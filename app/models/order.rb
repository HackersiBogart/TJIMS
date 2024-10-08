class Order < ApplicationRecord
  belongs_to :paint_color, optional: true
  has_many :order_paint_color
  has_many :mixes


  has_one_attached :image # Assuming Active Storage is set up for receipt images

  validates :name, :customer_email, :phone_number, :total, :size, :quantity, :item, :date_of_retrieval, :reference_number, :image, presence: true

  

end