class GithubEvent::DownloadEvent < GithubEvent
  field :payload, type: Hash, default: { download: {} }

  def info_string
    "Created download #{payload['download']['name']}"
  end
end
