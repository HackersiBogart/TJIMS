class AddOrdersToProducts < ActiveRecord::Migration[7.1]
  def change
    add_reference :products, :orders, foreign_key: true
  end
end
