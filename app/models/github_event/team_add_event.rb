class GithubEvent::TeamAddEvent < GithubEvent
  def info_string
    "Added #{payload['user']['name']} to #{payload['team']['name']}"
  end
end
