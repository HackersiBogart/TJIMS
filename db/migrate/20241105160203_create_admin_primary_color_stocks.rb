class CreateAdminPrimaryColorStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :primary_color_stocks do |t|
      t.string :size
      t.decimal :quantity
      t.decimal :price

      t.timestamps
    end
  end
end
