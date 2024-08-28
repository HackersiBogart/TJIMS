class CreateAdminPaintColors < ActiveRecord::Migration[7.1]
  def change
    create_table :paint_colors do |t|
      t.string :name
      t.string :code
      t.string :size
      t.integer :quantity
      t.integer :price
      t.references :color, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
