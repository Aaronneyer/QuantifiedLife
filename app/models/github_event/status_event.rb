class GithubEvent::StatusEvent < GithubEvent
  def info_string
    "You changed the state of #{payload['sha']} to #{payload['state']}"
  end
end
