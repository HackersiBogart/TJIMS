class AddProductIDtoColors < ActiveRecord::Migration[7.1]
  def change
    add_reference :colors, :product, null: false, foreign_key: true
  end
end
