json.extract! admin_order, :id, :customer_email, :fulfilled, :total, :reference_number, :phone_number, :name, :size, :quantity, :item, :date_of_retrieval,:created_at, :updated_at
json.url admin_order_url(admin_order, format: :json)
