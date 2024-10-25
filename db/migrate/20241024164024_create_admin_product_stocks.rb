class CreateAdminProductStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :product_stocks do |t|
      t.references :product, null: false, foreign_key: true
      t.string :size
      t.decimal :amount
      t.decimal :price
      t.string :unit

      t.timestamps
    end
  end
end
