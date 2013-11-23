class GithubEvent::ForkEvent < GithubEvent
  field :payload, type: Hash, default: {forkee: {}}

  def info_string
    "You forked #{repo['name']} to #{payload['forkee']['full_name']}"
  end
end
