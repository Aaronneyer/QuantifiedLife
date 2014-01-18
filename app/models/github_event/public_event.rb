class GithubEvent::PublicEvent < GithubEvent
  def info_string
    "You open sourced #{repo['name']}!"
  end
end
