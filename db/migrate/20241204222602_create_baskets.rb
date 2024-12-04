class CreateBaskets < ActiveRecord::Migration[7.1]
  def change
    create_table :baskets do |t|

      t.timestamps
    end
  end
end
