class CreateAdminColors < ActiveRecord::Migration[7.1]
  def change
    create_table :colors do |t|
      t.string :name
      t.string :code
      t.string :size
      t.integer :quantity

      t.timestamps
    end
  end
end
