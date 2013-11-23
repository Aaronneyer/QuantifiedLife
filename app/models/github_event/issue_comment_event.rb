class GithubEvent::IssueCommentEvent < GithubEvent
  field :payload, type: Hash, default: { action: '', issue: {}, comment: {} }

  def info_string
    "You commented on issue #{payload['issue']['url']}"
  end
end
