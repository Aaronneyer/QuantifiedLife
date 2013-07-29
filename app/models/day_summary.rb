class DaySummary < ActiveRecord::Base
  belongs_to :blog_post
  serialize :metadata, Hash

  metadata :hours_worked, :integer
end
