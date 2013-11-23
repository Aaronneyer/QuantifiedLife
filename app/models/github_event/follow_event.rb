class GithubEvent::FollowEvent < GithubEvent
  field :payload, type: Hash, default: {target: {}}

  def info_string
    "You followed #{payload['target']['login']}"
  end
end
