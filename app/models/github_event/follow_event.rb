class GithubEvent::FollowEvent < GithubEvent
  def info_string
    "You followed #{event['payload']['target']['login']}"
  end
end
