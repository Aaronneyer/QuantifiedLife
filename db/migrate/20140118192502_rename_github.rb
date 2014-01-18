class RenameGithub < ActiveRecord::Migration
  def change
    rename_table "newgithubs", "github_events"
  end
end
