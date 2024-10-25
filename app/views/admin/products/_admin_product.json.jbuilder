json.extract! admin_product, :id, :name, :description, :color_id, :order_id, :active, :created_at, :updated_at, :color_name, :color_code,:image
json.url admin_product_url(admin_product, format: :json)
