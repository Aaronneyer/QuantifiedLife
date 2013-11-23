class GithubEvent::PullRequestEvent < GithubEvent
  field :payload, type: Hash, default: {action: '', number: 0, pull_request: {}}

  def info_string
    "You #{payload['action']} the pull request at #{payload['pull_request']['url']}"
  end
end
