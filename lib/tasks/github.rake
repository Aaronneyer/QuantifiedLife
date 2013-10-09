namespace :github do
  task fetch_events: :environment do
    GithubEvent.delay.fetch_all_events
  end
end
