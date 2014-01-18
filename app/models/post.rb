class Post < ActiveRecord::Base
  belongs_to :user

  # Just for compatibility, will change later
  def tag_string
    tags
  end

  def tag_string=(new_tags)
    self.tags = new_tags
  end

  #TODO: Needs user specific
  def day
    Day.where(date: date).first
  end
end
