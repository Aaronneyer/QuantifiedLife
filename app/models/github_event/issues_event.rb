class GithubEvent::IssuesEvent < GithubEvent
  def info_string
    "You #{event['payload']['action']} the issue #{event['payload']['issue']['url']}"
  end
end
