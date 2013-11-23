class GithubEvent::WatchEvent < GithubEvent
  field :payload, type: Hash, default: { action: '' }

  def info_string
    "You #{payload['action']} watching #{repo['name']}"
  end
end
