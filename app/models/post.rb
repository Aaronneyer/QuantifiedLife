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

  def tag_string
    tags.join(' ')
  end

  def tag_string=(new_tags)
    self.tags = new_tags.split
  end

  def day
    Day.where(date: date).first
  end
end
