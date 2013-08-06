class ChangeBlogPostsToPosts < ActiveRecord::Migration
  def change
    rename_table :blog_posts, :posts
    rename_column :days, :blog_post_id, :post_id
  end
end
