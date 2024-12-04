class TransactionItem < ApplicationRecord
  belongs_to :sales_transact
  belongs_to :thing
end
