class CreateBasketItems < ActiveRecord::Migration[7.1]
  def change
    create_table :basket_items do |t|
      t.references :basket, null: false, foreign_key: true
      t.references :thing, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
