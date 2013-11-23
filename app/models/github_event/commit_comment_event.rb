class GithubEvent::CommitCommentEvent < GithubEvent
  field :payload, type: Hash, default: {comment: {}}
  
  def info_string
    "Commented on #{payload['comment']['commit_id']} with #{payload['comment']['body']}"
  end
end
