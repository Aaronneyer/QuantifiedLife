class GithubEvent::PushEvent < GithubEvent
  field :payload, type: Hash, default:
    { head: '', ref: '', size: 0, commits:
     [{ sha: '', message: '', url: '', distinct: true,
        author: { name: '', email: '' } }] }

  def info_string
    "You pushed #{pluralize(payload['commits'].count, "commit")} to #{repo['name']}"
  end
end
