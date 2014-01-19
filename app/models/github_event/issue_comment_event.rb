class GithubEvent::IssueCommentEvent < GithubEvent
  def info_string
    "You commented on issue #{event['payload']['issue']['url']}"
  end
end
