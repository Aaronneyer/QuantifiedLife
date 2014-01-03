class Day
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include ExtraInfoAttributes

  field :date, type: Date
  slug :date
  field :headline, type: String, default: ''
  field :summary, type: String
  field :impact, type: Fixnum
  field :extra_info, type: Hash, default: {}

  belongs_to :user

  index({ date: -1 }, { unique: true })

  validates :date, presence: true, uniqueness: true

  def posts
    Post.where(date: date)
  end

  def set_defaults(viewer)
    self.user_id ||= viewer.id
    self.extra_info ||= viewer.extra_info
    self.date ||= Date.yesterday
    self.impact ||= 0
  end
end
