class CustomerOrder < ApplicationRecord
  before_save :standardize_size
  has_one_attached :image
  # belongs_to :paint_color

  validates :customer_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :phone_number, presence: true, format: { with: /\A\+?[0-9]{10,15}\z/, message: "must be a valid phone number" }
  validates :reference_number, presence: true, uniqueness: true
  validates :image, presence: true
  validates :date_of_retrieval, presence: true
  # validates :color_id, presence: true
  # validates :product_id, presence: true
  validates :order_total, presence: true, numericality: { greater_than: 0 }


  private

  def standardize_size
    self.size = size.sub(/^0+/, '') if size.present?
  end
end
