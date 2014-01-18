class GithubEvent::IssuesEvent < GithubEvent
  def info_string
    "You #{payload['action']} the issue #{payload['issue']['url']}"
  end
end
