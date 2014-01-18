class GithubEvent::MemberEvent < GithubEvent
  def info_string
    "You added #{payload['member']['login']} to #{repo['name']}"
  end
end
