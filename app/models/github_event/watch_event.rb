class GithubEvent::WatchEvent < GithubEvent
  def info_string
    "You #{payload['action']} watching #{repo['name']}"
  end
end
