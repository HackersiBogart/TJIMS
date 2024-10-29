class AddStockInfoToPaintColors < ActiveRecord::Migration[7.1]
  def change
    add_column :paint_colors, :previous_stocks, :integer
    add_column :paint_colors, :added_stocks, :integer
  end
end
