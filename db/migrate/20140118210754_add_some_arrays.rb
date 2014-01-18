class AddSomeArrays < ActiveRecord::Migration
  def change
    remove_column :users, :location_string
    add_column :users, :locations, :string, array: true, default: []
    add_column :users, :permitted_viewers, :string, array: true, default: []
    remove_column :posts, :tags
    add_column :posts, :tags, :string, array: true, default: []
  end
end
