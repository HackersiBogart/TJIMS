class Order < ApplicationRecord
  belongs_to :paint_color, optional: true
  has_many :mixes
  belongs_to :products
  belongs_to :primary_colors


  has_one_attached :image # Assuming Active Storage is set up for receipt images

  validates :name, :customer_email, :phone_number, :total, :size, :quantity, :item, :date_of_retrieval, :reference_number, :image, presence: true

  

end