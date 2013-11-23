class GithubEvent::TeamAddEvent < GithubEvent
  field :payload, type: Hash, default: {team: {}, user: {}, repo: {}}

  def info_string
    "Added #{payload['user']['name']} to #{payload['team']['name']
  end
end
