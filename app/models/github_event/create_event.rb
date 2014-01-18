class GithubEvent::CreateEvent < GithubEvent
  def info_string
    case payload['ref_type']
    when 'repository'
      "Created #{repo['name']} repository"
    when 'branch'
      "Created branch #{payload['ref']} in #{repo['name']}"
    when 'tag'
      "Created tag #{payload['ref']} in #{repo['name']}"
    end
  end
end
