json.extract! admin_product, :id, :name, :description, :color_id, :active, :created_at, :updated_at, :color_name, :color_code
json.url admin_product_url(admin_product, format: :json)
