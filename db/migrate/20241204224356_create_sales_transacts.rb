class CreateSalesTransacts < ActiveRecord::Migration[7.1]
  def change
    create_table :sales_transacts do |t|
      t.string :customer_name
      t.string :customer_email
      t.string :phone_number
      t.decimal :total

      t.timestamps
    end
  end
end
