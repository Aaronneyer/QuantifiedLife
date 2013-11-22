class GithubEvent
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include ActionView::Helpers

  belongs_to :user
  field :created_at, type: Time
  field :type, type: String
  field :payload, type: Hash
  field :repo, type: Hash
  field :actor, type: Hash
  field :org, type: Hash
  field :id, type: String
  field :public, type: Boolean

  index({ user_id: 1, created_at: 1 })
  index({ created_at: 1 })

  VALID_TYPES = %w[
    CommitCommentEvent CreateEvent DeleteEvent DownloadEvent FollowEvent
    ForkEvent ForkApplyEvent GistEvent GollumEvent IssueCommentEvent IssuesEvent
    MemberEvent PublicEvent PullRequestEvent PullRequestReviewCommentEvent
    PushEvent ReleaseEvent StatusEvent TeamAddEvent WatchEvent
  ]
  before_create :set_type

  # TODO: These should probably be partials that I render for the timeline.
  # OH MY GOD THERE ARE SO MANY STRINGS
  def info_string
    case type
    when 'CommitCommentEvent'
      "Commented on #{payload['comment']['commit_id']} with #{payload['comment']['body']}"
    when 'CreateEvent'
      case payload['ref_type']
      when 'repository'
        "Created #{repo['name']} repository"
      when 'branch'
        "Created branch #{payload['ref']} in #{repo['name']}"
      when 'tag'
        "Created tag #{payload['ref']} in #{repo['name']}"
      end
    when 'DeleteEvent'
      "Deleted #{payload['ref_type']} #{payload['ref']} in #{repo['name']}"
    when 'DownloadEvent'
      "You downloaded something"
    when 'FollowEvent'
      "You followed #{payload['target']['login']}"
    when 'ForkEvent'
      "You forked #{repo['name']} to #{payload['forkee']['full_name']}"
    when 'ForkApplyEvent'
      "You forkapplied something!"
    when 'GistEvent'
      "You gisted something!"
    when 'GollumEvent'
      "You gollumed! (Should iterate over the pages)"
    when 'IssueCommentEvent'
      "You commented on issue #{payload['issue']['url']}"
    when 'IssuesEvent'
      "You #{payload['action']} the issue #{payload['issue']['url']}"
    when 'MemberEvent'
      "You added #{payload['member']['login']} to #{repo['name']}"
    when 'PublicEvent'
      "You open sourced #{repo['name']}!"
    when 'PullRequestEvent'
      "You #{payload['action']} the pull request at #{payload['pull_request']['url']}"
    when 'PullRequestReviewCommentEvent'
      "You uhh... that thing..."
    when 'PushEvent'
      "You pushed #{pluralize(payload['commits'].count, "commit")} to #{repo['name']}"
    when 'TeamAddEvent'
      "Team add thing"
    when 'WatchEvent'
      "You #{payload['action']} watching #{repo['name']}"
    end
  end

  class << self
    # This job is called asynchronously every day
    def fetch_all_events
      User.each{ |u| fetch_events(u.id) }
      Github.delay_for(1.day).fetch_all_events
    end

    def fetch_events(user_id)
      user = User.find(user_id)
      return unless user.github_token
      gh = Github.new(oauth_token: user.github_token)
      done = false
      gh.activity.events.performed(gh.users.get.login, public: user.github_private).each_page do |page|
        page.each do |event|
          if GithubEvent.where(id: event.id, user_id: user.id).exists?
            done = true
            break
          else
            # ActiveModel lets through a hash but not a hashie.
            GithubEvent.create!(event.merge(user_id: user.id).to_hash)
          end
        end
        break if done
      end
    end

    def backfill(user_id)
      #TODO: Some Bigquery stuff here for more through public backfill
      fetch_events(user_id)
    end
  end

  private

  def set_type
    if type.in? VALID_TYPES
      self['_type'] = "GithubEvent::#{type}"
    end
  end
end
