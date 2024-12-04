class CreateTransactionItems < ActiveRecord::Migration[7.1]
  def change
    create_table :transaction_items do |t|
      t.references :sales_transact, null: false, foreign_key: true
      t.references :thing, null: false, foreign_key: true
      t.string :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
