json.array!(@day_summaries) do |day_summary|
  json.extract! day_summary, :day, :summary, :blog_post_id, :metadata
  json.url day_summary_url(day_summary, format: :json)
end
