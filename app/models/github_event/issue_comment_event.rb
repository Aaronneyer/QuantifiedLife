class GithubEvent::IssueCommentEvent < GithubEvent
  def info_string
    "You commented on issue #{payload['issue']['url']}"
  end
end
