class AddForeignToOrders < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :orders, :colors  # Linking orders to colors table
    add_foreign_key :orders, :products  # Linking orders to products table
    add_foreign_key :orders, :paint_colors  # Linking orders to paint_colors table
    add_foreign_key :orders, :primary_colors  # Linking orders to primary_colors table
  end
end
