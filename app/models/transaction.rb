class Transaction < ApplicationRecord
  has_many :transaction_items, dependent: :destroy
end
