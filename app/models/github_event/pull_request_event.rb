class GithubEvent::PullRequestEvent < GithubEvent
  def info_string
    "You #{payload['action']} the pull request at #{payload['pull_request']['url']}"
  end
end
