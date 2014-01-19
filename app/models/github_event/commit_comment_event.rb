class GithubEvent::CommitCommentEvent < GithubEvent
  def info_string
    "Commented on #{event['payload']['comment']['commit_id']} with #{event['payload']['comment']['body']}"
  end
end
