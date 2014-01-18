class GithubEvent::ForkEvent < GithubEvent
  def info_string
    "You forked #{repo['name']} to #{payload['forkee']['full_name']}"
  end
end
