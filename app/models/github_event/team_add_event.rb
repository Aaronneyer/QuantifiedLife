class GithubEvent::TeamAddEvent < GithubEvent
  def info_string
    "Added #{event['payload']['user']['name']} to #{event['payload']['team']['name']}"
  end
end
