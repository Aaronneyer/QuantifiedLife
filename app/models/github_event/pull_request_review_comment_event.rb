class GithubEvent::PullRequestReviewCommentEvent < GithubEvent
  def info_string
    'You commented on a pull request'
  end
end
