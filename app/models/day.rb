class Day < ActiveRecord::Base
  include ExtraInfoAttributes

  belongs_to :user

  validates :date, presence: true, uniqueness: true

  after_initialize :defaults, unless: :persisted?

  after_create :add_locations
  after_create :async_fetch_data

  def defaults
    self.date ||= Date.yesterday
    self.end_location ||= start_location
    self.extra_info ||= user.try(:extra_info) || {}
    self.headline ||= ''
    self.moves_storyline ||= {}
    self.moves_summary ||= {}
    self.impact ||= 0
  end

  def posts
    Post.where(date: date, user_id: id)
  end

  def add_locations
    [start_location, end_location].each do |location|
      if location.present? && !user.locations.include?(location)
        user.locations << location
        user.save
      end
    end
  end

  def self.fetch_moves(day_id)
    Day.find(day_id).fetch_moves
  end

  def fetch_moves
    return unless user.moves_token
    client = Moves::Client.new(user.moves_token)
    self.moves_storyline = client.daily_storyline(date).first
    self.moves_summary = client.daily_summary(date).first
    self.save
  rescue RestClient::BadRequest
  end

  #TODO: As more API's become integrated, have this start up tasks to fetch everything
  def async_fetch_data
    Day.delay.fetch_moves(self.id)
  end

  def moves_places
    return [] unless moves_storyline['segments']
    moves_storyline['segments'].select{ |segment| segment['type'] == 'place' }.
      map{ |segment| segment['place']['name'] }.compact
  end
end
