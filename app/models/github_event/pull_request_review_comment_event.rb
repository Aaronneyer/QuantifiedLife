class GithubEvent::PullRequestReviewCommentEvent < GithubEvent
  field :payload, type: Hash, default: {comment: {}}

  def info_string
    "You commented on a pull request"
  end
end
