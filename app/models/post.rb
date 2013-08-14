class Post < ActiveRecord::Base
  belongs_to :day

  def date
    day.try(:date)
  end

  def date=(value)
    self.day = Day.find_or_create_by(date: value)
  end
end
