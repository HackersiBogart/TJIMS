class AddReferenceNumberAndDateOfRetrievalToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :reference_number, :string
    add_column :orders, :date_of_retrieval, :datetime
  end
end
