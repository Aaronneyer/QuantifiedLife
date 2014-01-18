class GithubEvent::FollowEvent < GithubEvent
  def info_string
    "You followed #{payload['target']['login']}"
  end
end
