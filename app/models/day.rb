class Day < ActiveRecord::Base
  belongs_to :blog_post
  serialize :metadata, Hash
  validates :date, uniqueness: true, presence: true
  validates :summary, presence: true

  metadata :hours_worked, :integer
  metadata :miles_walked, :integer
  metadata :trees, :boolean
end
