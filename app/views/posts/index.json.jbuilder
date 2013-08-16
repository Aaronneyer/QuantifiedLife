json.array!(@posts) do |post|
  json.extract! post, :title, :body, :related_date
  json.url post_url(post, format: :json)
end
