class RenameNewTables < ActiveRecord::Migration
  def change
    rename_table "newusers", "users"
    rename_table "newdays", "days"
    rename_table "newposts", "posts"
  end
end
