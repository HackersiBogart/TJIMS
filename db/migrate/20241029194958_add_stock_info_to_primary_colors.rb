class AddStockInfoToPrimaryColors < ActiveRecord::Migration[7.1]
  def change
    add_column :primary_colors, :previous_stocks, :integer
    add_column :primary_colors, :added_stocks, :integer
  end
end
