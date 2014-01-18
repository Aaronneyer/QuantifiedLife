class GithubEvent::ReleaseEvent < GithubEvent
  def info_string
    "You #{payload['action']} #{release['name']}"
  end
end
