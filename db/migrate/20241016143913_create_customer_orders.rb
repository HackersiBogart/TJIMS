class CreateCustomerOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :customer_orders do |t|
      t.string :customer_email
      t.string :name
      t.string :phone_number
      t.string :reference_number
      t.date :date_of_retrieval
      t.decimal :total
      t.string :size
      t.integer :quantity
      t.string :items

      t.timestamps
    end
  end
end
