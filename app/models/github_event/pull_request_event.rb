class GithubEvent::PullRequestEvent < GithubEvent
  def info_string
    "You #{event['payload']['action']} the pull request at #{event['payload']['pull_request']['url']}"
  end
end
