class GithubEvent::CommitCommentEvent < GithubEvent
  def info_string
    "Commented on #{payload['comment']['commit_id']} with #{payload['comment']['body']}"
  end
end
