class GithubEvent::DeleteEvent < GithubEvent
  field :payload, type: Hash, default: {ref_type: '', ref: ''}
  
  def info_string
    "Deleted #{payload['ref_type']} #{payload['ref']} in #{repo['name']}"
  end
end
