class GithubEvent
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include ActionView::Helpers

  belongs_to :user

  index({ user_id: 1 })

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
    def fetch_all_events
      User.each{ |u| fetch_events(u.id) }
      Github.delay_for(1.day).fetch_all_events
    end

    def fetch_events(user_id)
      user = User.find(user_id)
      if user.github_token
        gh = Github.new(oauth_token: user.github_token)
        done = false
        gh.activity.events.performed(gh.users.get.login, public: user.github_private).each_page do |page|
          page.each do |event|
            update_params = ActionController::Parameters.new(event.merge(user_id: user.id)).permit!
            if GithubEvent.where(id: event.id, user_id: user.id).exists?
              done = true
              break
            else
              GithubEvent.create!(update_params)
            end
          end
          break if done
        end
      end
    end

    def backfill(user_id)
      #TODO: Some Bigquery stuff here for more through public backfill
      user = User.find(user_id)
      gh = Github.new(oauth_token: user.github_token)
      gh.activity.events.performed(gh.users.get.login, public: user.github_private).each_page do |page|
        page.each do |event|
          update_params = ActionController::Parameters.new(event.merge(user_id: user.id)).permit!
          ge = GithubEvent.find_or_initialize_by(id: event.id, user_id: user.id)
          ge.update_attributes(update_params)
        end
      end
    end
  end
end
