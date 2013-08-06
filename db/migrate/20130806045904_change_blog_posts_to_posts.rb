class ChangeBlogPostsToPosts < ActiveRecord::Migration
  def change
    rename_table :blog_posts, :posts
    change_column :days, :blog_post_id, :post_id
  end
end
