class User < ActiveRecord::Base
  include ExtraInfoAttributes

  has_many :github_events
  has_many :photos
  has_many :posts
  has_many :days

  def can_view?(user)
    can_edit?(user)# || user.permitted_viewers.include?(self.id)
  end

  def can_edit?(user)
    admin? || user == self
  end
end
