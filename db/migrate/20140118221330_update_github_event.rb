class UpdateGithubEvent < ActiveRecord::Migration
  def change
    rename_column :github_events, :info, :event
    add_column :github_events, :user_id, :string, index: true
    add_column :github_events, :github_id, :string
  end
end
