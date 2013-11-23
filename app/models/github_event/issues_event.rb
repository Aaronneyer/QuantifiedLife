class GithubEvent::IssuesEvent < GithubEvent
  field :payload, type: Hash, default: { action: '', issue: {} }

  def info_string
    "You #{payload['action']} the issue #{payload['issue']['url']}"
  end
end
