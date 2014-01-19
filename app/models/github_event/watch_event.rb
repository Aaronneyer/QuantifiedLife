class GithubEvent::WatchEvent < GithubEvent
  def info_string
    "You #{event['payload']['action']} watching #{event['repo']['name']}"
  end
end
