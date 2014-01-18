class GithubEvent::ForkApplyEvent < GithubEvent
  def info_string
    'Fork Applied (Deprecated)'
  end
end
