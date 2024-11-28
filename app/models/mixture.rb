class Mixture < ApplicationRecord
  belongs_to :order
  belongs_to :primary_color
  before_save :check_and_deduct_stock_vone
  before_save :check_and_deduct_stock_vtwo
  before_save :check_and_deduct_stock_vthree
  has_many :mixture_details, dependent: :destroy
  has_many :mixture_thirds, dependent: :destroy
  accepts_nested_attributes_for :mixture_details, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :mixture_thirds, allow_destroy: true, reject_if: :all_blank
  

  validates :order_id, presence: true, numericality: { only_integer: true, message: "must be a valid number" }
  validates :primary_color_id, presence: true, numericality: { only_integer: true, message: "must be a valid number" }
  validates :amount, presence: true, numericality: { greater_than: 0, message: "must be greater than 0" }
 
  


  private

  def check_and_deduct_stock_vone
    if primary_color.stocks >= amount
      primary_color.deduct_stock!(amount)
    else
      errors.add(:base, "Not enough stock available")
      throw(:abort) # Prevent the record from being saved
    end
  end

  def check_and_deduct_stock_vtwo
    mixture_details.each do |mixture_detail|
      primary_color = mixture_detail.primary_color
      if primary_color.stocks >= mixture_detail.amount
        primary_color.deduct_stock!(mixture_detail.amount)
      else
        errors.add(:base, "Not enough stock available for color #{primary_color.color_name}")
        throw(:abort) # Prevent saving if any stock is insufficient
      end
    end
  end

  def check_and_deduct_stock_vthree
    mixture_thirds.each do |mixture_third|
      primary_color = mixture_third.primary_color
      if primary_color.stocks >= mixture_third.amount
        primary_color.deduct_stock!(mixture_third.amount)
      else
        errors.add(:base, "Not enough stock available for color #{primary_color.color_name}")
        throw(:abort) # Prevent saving if any stock is insufficient
      end
    end
  end
end
