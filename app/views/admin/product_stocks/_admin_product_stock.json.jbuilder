json.extract! admin_product_stock, :id, :product_id, :size, :amount, :price,:created_at, :updated_at
json.url admin_product_stock_url(admin_product_stock, format: :json)
