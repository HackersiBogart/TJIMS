class AddPrimaryColorIdToMixes < ActiveRecord::Migration[7.1]
  def change
    add_column :mixes, :primary_color_id, :integer
    add_foreign_key :mixes, :primary_colors, column: :primary_color_id
  end
end
