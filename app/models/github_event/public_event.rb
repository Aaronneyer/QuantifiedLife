class GithubEvent::PublicEvent < GithubEvent
  field :payload, type: Hash, default: {}

  def info_string
    "You open sourced #{repo['name']}!"
  end
end
