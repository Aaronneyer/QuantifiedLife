class GithubEvent < ActiveRecord::Base
  include ActionView::Helpers

  belongs_to :user

  VALID_TYPES = %w[
    CommitCommentEvent CreateEvent DeleteEvent DownloadEvent FollowEvent
    ForkEvent ForkApplyEvent GistEvent GollumEvent IssueCommentEvent IssuesEvent
    MemberEvent PublicEvent PullRequestEvent PullRequestReviewCommentEvent
    PushEvent ReleaseEvent StatusEvent TeamAddEvent WatchEvent
  ]
  before_create :set_type

  def info_string
    'Unknown Github Event Type'
  end

  # This is a temporary shim until I fix the event structure
  def method_missing(meth, *args)
    info[meth.to_s]
  end

  class << self
    # This job is called asynchronously every day
    def fetch_all_events
      User.each { |u| fetch_events(u.id) }
      Github.delay_for(1.day).fetch_all_events
    end

    def fetch_events(user_id)
      user = User.find(user_id)
      return unless user.github_token
      gh = Github.new(oauth_token: user.github_token)
      done = false
      gh.activity.events.performed(gh.users.get.login, public: user.github_private).each_page do |page|
        page.each do |event|
          if GithubEvent.where(github_id: event.id, user_id: user.id).exists?
            done = true
            break
          else
            # ActiveModel lets through a hash but not a hashie.
            GithubEvent.create!(info: event.to_hash, github_id: event['id'], user_id: user.id)
          end
        end
        break if done
      end
    end

    def backfill(user_id)
      # TODO: Some Bigquery stuff here for more through public backfill
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
