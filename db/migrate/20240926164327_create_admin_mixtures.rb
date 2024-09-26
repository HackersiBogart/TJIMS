class CreateAdminMixtures < ActiveRecord::Migration[7.1]
  def change
    create_table :mixtures do |t|
      t.references :order, null: false, foreign_key: true
      t.references :primary_color, null: false, foreign_key: true
      t.decimal :amount

      t.timestamps
    end
  end
end
