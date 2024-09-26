class AddOrderIdToMixes < ActiveRecord::Migration[7.1]
  def change
    add_column :mixes, :order_id, :integer
    add_foreign_key :mixes, :orders, column: :order_id
  end
end
