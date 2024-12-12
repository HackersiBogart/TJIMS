class Order < ApplicationRecord
  belongs_to :color
  belongs_to :paint_color, optional: true
  belongs_to :product
  belongs_to :primary_color, optional: true
  has_many :mixes
  has_many :products, class_name: 'Product', foreign_key: 'order_id', dependent: :destroy
  has_many :colors
  has_many :products
  has_many :mixtures
  has_many :mixture_details
  has_many :mixture_thirds
  accepts_nested_attributes_for :mixture_details, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :mixture_thirds, allow_destroy: true, reject_if: :all_blank

  has_one_attached :image # Assuming Active Storage is set up for receipt images

  validates :name, :customer_email, :phone_number, :total, :size, :quantity,  :date_of_retrieval, :reference_number, :image, presence: true
end
