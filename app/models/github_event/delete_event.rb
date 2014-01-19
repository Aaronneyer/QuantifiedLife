class GithubEvent::DeleteEvent < GithubEvent
  def info_string
    "Deleted #{event['payload']['ref_type']} #{event['payload']['ref']} in #{event['repo']['name']}"
  end
end
