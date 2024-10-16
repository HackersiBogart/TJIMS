class AddProductIdToPaintColors < ActiveRecord::Migration[7.1]
  def change
    add_column :paint_colors, :product_id, :integer
    add_foreign_key :paint_colors, :products
    add_index :paint_colors, :product_id
  end
end
