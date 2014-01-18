class GithubEvent::DownloadEvent < GithubEvent
  def info_string
    "Created download #{payload['download']['name']}"
  end
end
