json.extract! product, :id, :title, :desc, :created_at, :updated_at
json.url product_url(product, format: :json)
