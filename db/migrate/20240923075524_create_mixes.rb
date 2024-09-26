class CreateMixes < ActiveRecord::Migration[7.1]
  def change
    create_table :mixes do |t|
      t.references :paint_color, null: false, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
