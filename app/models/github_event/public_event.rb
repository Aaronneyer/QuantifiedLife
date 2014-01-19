class GithubEvent::PublicEvent < GithubEvent
  def info_string
    "You open sourced #{event['repo']['name']}!"
  end
end
