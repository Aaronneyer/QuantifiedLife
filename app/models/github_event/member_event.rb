class GithubEvent::MemberEvent < GithubEvent
  def info_string
    "You added #{event['payload']['member']['login']} to #{event['repo']['name']}"
  end
end
