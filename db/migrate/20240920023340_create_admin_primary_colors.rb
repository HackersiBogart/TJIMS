class CreateAdminPrimaryColors < ActiveRecord::Migration[7.1]
  def change
    create_table :primary_colors do |t|
      t.string :color_name
      t.string :color_code
      t.decimal :price
      t.decimal :stocks
      t.boolean :active

      t.timestamps
    end
  end
end
