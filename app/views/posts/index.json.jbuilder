json.array!(@posts) do |post|
  json.extract! post, :title, :body, :date
  json.url post_url(post, format: :json)
end
