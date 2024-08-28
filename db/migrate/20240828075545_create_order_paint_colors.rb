class CreateOrderPaintColors < ActiveRecord::Migration[7.1]
  def change
    create_table :order_paint_colors do |t|
      t.references :paint_color, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.string :size
      t.integer :quantity

      t.timestamps
    end
  end
end
