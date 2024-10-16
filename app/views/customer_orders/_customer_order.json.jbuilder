json.extract! customer_order, :id, :customer_email, :name, :phone_number, :reference_number, :date_of_retrieval, :total, :order_total, :size, :quantity, :item, :image, :created_at, :updated_at
json.url customer_order_url(customer_order, format: :json)
