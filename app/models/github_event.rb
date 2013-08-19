class GithubEvent
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  belongs_to :user

  index({ user_id: 1 })

  #TODO: These should probably be partials that I render for the timeline.
  def info_string
    case type
    when "CommitCommentEvent"
      "Commented on #{payload['comment']['commit_id']} with #{payload['comment']['body']}"
    end
  end

  class << self
    def fetch_events
      User.each(&:fetch_events)
    end
  end
end