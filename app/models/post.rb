class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :title, type: String
  slug :title, history: true
  field :body, type: String
  field :date, type: Date
  field :impact, type: Fixnum
  field :tags, type: Array, default: []

  index({ date: -1 })

  def tags=(new_tags)
    if new_tags.is_a?(String)
      new_tags = new_tags.split
    end
    super(new_tags)
  end

  def day
    Day.where(date: date).first
  end
end
