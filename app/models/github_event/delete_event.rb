class GithubEvent::DeleteEvent < GithubEvent
  def info_string
    "Deleted #{payload['ref_type']} #{payload['ref']} in #{repo['name']}"
  end
end
