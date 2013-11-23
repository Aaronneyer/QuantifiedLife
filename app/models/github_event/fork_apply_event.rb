class GithubEvent::ForkApplyEvent < GithubEvent
  field :payload, type: Hash, default: { forkee: {} }

  def info_string
    'Fork Applied (Deprecated)'
  end
end
