namespace :github do
  task fetch_events: :environment do
    GithubEvent.delay.fetch_events
  end
end
