class ChangeBlogPostsToPosts < ActiveRecord::Migration
  def change
    rename_table :posts, :posts
    change_column :days, :post_id, :post_id
  end
end
