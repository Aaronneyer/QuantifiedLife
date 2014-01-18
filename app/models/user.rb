class User < ActiveRecord::Base
  include Clearance::User
  include ExtraInfoAttributes

  has_many :github_events
  has_many :photos
  has_many :posts
  has_many :days

  #JANK: Fix this with arrays once I get postgres to do it right
  def locations
    location_string.split(' ')
  end

  def can_view?(user)
    can_edit?(user)# || user.permitted_viewers.include?(self.id)
  end

  def can_edit?(user)
    admin? || user == self
  end
end
