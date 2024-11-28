class CustomerOrder < ApplicationRecord
  before_save :standardize_size
  has_one_attached :image
  validates :date_of_retrieval, presence: true
  belongs_to :paint_color




  private

  def standardize_size
    self.size = size.sub(/^0+/, '') if size.present?
  end
end
