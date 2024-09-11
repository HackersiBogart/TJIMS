class CreateCheckouts < ActiveRecord::Migration[6.1]
  def change
    create_table :checkouts do |t|
      t.string :reference_number
      t.date :date_of_retrieval # Add this line here as well if you want to create the table and add the column at the same time
      t.timestamps
    end
  end
end