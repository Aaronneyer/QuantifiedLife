class RenameDropboxUrlToPathAndAddUserId < ActiveRecord::Migration
  def change
    rename_column :photos, :dropbox_url, :dropbox_path
    add_column :photos, :user_id, :integer
  end
end
