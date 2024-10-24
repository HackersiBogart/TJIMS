json.extract! admin_order, :id, :customer_email, :fulfilled, :total, :reference_number, :phone_number, 
:name, :size, :quantity, :item, :date_of_retrieval, :product_id, 
:paint_color_id, :color_id, :primary_color_id, :order_total, :image, :created_at, :updated_at
json.url admin_order_url(admin_order, format: :json)
