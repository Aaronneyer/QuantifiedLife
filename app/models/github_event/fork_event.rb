class GithubEvent::ForkEvent < GithubEvent
  def info_string
    "You forked #{event['repo']['name']} to #{event['payload']['forkee']['full_name']}"
  end
end
