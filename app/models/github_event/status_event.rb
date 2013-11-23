class GithubEvent::StatusEvent < GithubEvent
  field :payload, type: Hash, default: 
    {sha: '', state: '', description: '', target_url: '', branches: []}

  def info_string
    "You changed the state of #{payload['sha']} to #{payload['state']}"
  end
end
