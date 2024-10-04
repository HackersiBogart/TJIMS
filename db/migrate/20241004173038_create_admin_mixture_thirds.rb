class CreateAdminMixtureThirds < ActiveRecord::Migration[7.1]
  def change
    create_table :mixture_thirds do |t|
      t.references :mixture, null: false, foreign_key: true
      t.integer :order_id
      t.integer :primary_color_id
      t.decimal :amount

      t.timestamps
    end
  end
end
