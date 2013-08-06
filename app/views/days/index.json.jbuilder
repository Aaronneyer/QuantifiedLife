json.array!(@days) do |day|
  json.extract! day, :date, :summary, :post_id, :metadata
  json.url day_url(day, format: :json)
end
