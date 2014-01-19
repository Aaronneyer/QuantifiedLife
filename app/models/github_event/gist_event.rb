class GithubEvent::GistEvent < GithubEvent
  def info_string
    "You #{event['payload']['action']}d a gist"
  end
end
