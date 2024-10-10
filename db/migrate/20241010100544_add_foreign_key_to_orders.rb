class AddForeignKeyToOrders < ActiveRecord::Migration[7.1]
  def change
    # Add the columns first if they don't exist
    add_column :orders, :color_id, :integer unless column_exists?(:orders, :color_id)
    add_column :orders, :product_id, :integer unless column_exists?(:orders, :product_id)
    add_column :orders, :paint_color_id, :integer unless column_exists?(:orders, :paint_color_id)
    add_column :orders, :primary_color_id, :integer unless column_exists?(:orders, :primary_color_id)

  end
end
