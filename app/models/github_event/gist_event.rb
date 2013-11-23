class GithubEvent::GistEvent < GithubEvent
  field :payload, type: Hash, default: { action: '', gist: {} }

  def info_string
    "You #{payload['action']}d a gist"
  end
end
