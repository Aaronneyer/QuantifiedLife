class GithubEvent::DownloadEvent < GithubEvent
  def info_string
    "Created download #{event['payload']['download']['name']}"
  end
end
