class GithubEvent::ReleaseEvent < GithubEvent
  def info_string
    "You #{event['payload']['action']} #{event['release']['name']}"
  end
end
