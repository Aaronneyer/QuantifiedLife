class GithubEvent::GistEvent < GithubEvent
  def info_string
    "You #{payload['action']}d a gist"
  end
end
