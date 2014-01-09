class Day
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug
  include ExtraInfoAttributes

  field :date, type: Date, default: -> { Date.yesterday }
  slug :date
  field :headline, type: String, default: ''
  field :summary, type: String
  field :start_location, type: String
  field :end_location, type: String, default: -> { start_location }
  field :impact, type: Fixnum, default: 0
  field :extra_info, type: Hash, default: -> { user.try(:extra_info) || {} }
  field :moves_storyline, type: Hash, default: {}
  field :moves_summary, type: Hash, default: {}

  belongs_to :user

  index({ date: -1 }, { unique: true })

  validates :date, presence: true, uniqueness: true

  after_create :add_locations

  def posts
    Post.where(date: date)
  end

  def add_locations
    [start_location, end_location].each do |location|
      if location.present? && !user.locations.include?(location)
        user.locations << location
        user.save
      end
    end
  end

  def fetch_moves
    client = Moves::Client.new(user.moves_token)
    self.moves_storyline = client.daily_storyline(date).first
    self.moves_summary = client.daily_summary(date).first
    self.save
  end

  def moves_places
    moves_storyline['segments'].select{ |segment| segment['type'] == 'place' }.
      map{ |segment| segment['place']['name'] }.compact
  end
end
