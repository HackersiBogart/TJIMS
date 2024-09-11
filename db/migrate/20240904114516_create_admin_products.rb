class CreateAdminProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.boolean :active
      t.text :color_name
      t.text :color_code

      t.timestamps
    end
  end
end
