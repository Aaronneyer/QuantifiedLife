class GithubEvent
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  #TODO: These should probably be partials that I render for the timeline.
  def info_string
    case type
    when "CommitCommentEvent"
      "Commented on #{payload['comment']['commit_id']} with #{payload['comment']['body']}"
    end
  end
end
