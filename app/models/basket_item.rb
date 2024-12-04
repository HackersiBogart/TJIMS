class BasketItem < ApplicationRecord
  belongs_to :basket
  belongs_to :thing
end
