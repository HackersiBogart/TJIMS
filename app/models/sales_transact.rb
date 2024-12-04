class SalesTransact < ApplicationRecord
  has_many :transaction_items, dependent: :destroy
end
