json.array!(@media) do |medium|
  json.extract! medium, :id, :attachment, :post_id, :comment_id
  json.url medium_url(medium, format: :json)
end
