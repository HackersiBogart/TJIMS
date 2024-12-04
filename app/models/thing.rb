class Thing < ApplicationRecord
  has_many :basket_items
  has_many :transaction_items
end
