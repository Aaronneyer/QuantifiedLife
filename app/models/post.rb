class Post < ActiveRecord::Base
  belongs_to :user

  def tag_string
    tags.join(' ')
  end

  def tag_string=(new_tags)
    self.tags = new_tags.split(' ')
  end

  #TODO: Needs user specific
  def day
    Day.where(date: date).first
  end
end
