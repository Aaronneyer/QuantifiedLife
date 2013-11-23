class GithubEvent::ReleaseEvent < GithubEvent
  field :payload, type: Hash, default: { action: '', release: {} }

  def info_string
    "You #{payload['action']} #{release['name']}"
  end
end
