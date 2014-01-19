class GithubEvent::CreateEvent < GithubEvent
  def info_string
    case event['payload']['ref_type']
    when 'repository'
      "Created #{event['repo']['name']} repository"
    when 'branch'
      "Created branch #{event['payload']['ref']} in #{event['repo']['name']}"
    when 'tag'
      "Created tag #{event['payload']['ref']} in #{event['repo']['name']}"
    end
  end
end
