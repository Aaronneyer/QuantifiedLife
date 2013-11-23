class GithubEvent::GollumEvent < GithubEvent
  field :payload, type: Hash, default:
    {pages: [{page_name: '', title: '', action: '', sha: '', html_url: ''}]}

  def info_string
    "You created/updated #{payload['pages'].count} pages"
  end
end
