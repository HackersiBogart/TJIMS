class CreateThings < ActiveRecord::Migration[7.1]
  def change
    create_table :things do |t|
      t.string :name
      t.decimal :price
      t.integer :stock

      t.timestamps
    end
  end
end
