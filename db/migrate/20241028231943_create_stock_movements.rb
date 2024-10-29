class CreateStockMovements < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_movements do |t|
      t.references :product, null: false, foreign_key: true
      t.references :primary_color, null: false, foreign_key: true
      t.references :paint_color, null: false, foreign_key: true
      t.string :movement_type
      t.integer :quantity

      t.timestamps
    end
  end
end
