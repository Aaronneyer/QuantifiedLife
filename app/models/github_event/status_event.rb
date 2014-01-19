class GithubEvent::StatusEvent < GithubEvent
  def info_string
    "You changed the state of #{event['payload']['sha']} to #{event['payload']['state']}"
  end
end
