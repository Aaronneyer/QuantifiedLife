namespace :github do
  task fetch_events: :environment do
    User.each do |user|
      if user.github_token
        gh = Github.new(oauth_token: user.github_token)
        gh_user = gh.users.get
        done = false
        gh.activity.events.performed(gh_user.login).each_page do |page|
          page.each do |event|
            if GithubEvent.where(id: event.id).exists?
              done = true
              break
            else
              GithubEvent.create!(ActionController::Parameters.new(event).permit!)
            end
          end
          break if done
        end
      end
    end
  end
end
