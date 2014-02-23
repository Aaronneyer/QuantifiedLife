class Post < ActiveRecord::Base
  belongs_to :user

  def tag_string
    tags.join(',')
  end

  def tag_string=(new_tags)
    self.tags = new_tags.split(',')
  end

  def day
    Day.where(date: date, user_id: user.id).first
  end
end
