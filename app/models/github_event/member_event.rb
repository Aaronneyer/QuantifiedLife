class GithubEvent::MemberEvent < GithubEvent
  field :payload, type: Hash, default: { member: {}, action: '' }

  def info_string
    "You added #{payload['member']['login']} to #{repo['name']}"
  end
end
