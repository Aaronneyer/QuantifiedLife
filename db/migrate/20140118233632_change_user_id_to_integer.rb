class ChangeUserIdToInteger < ActiveRecord::Migration
  def change
    remove_column :github_events, :user_id, :string
    add_column :github_events, :user_id, :integer
  end
end
