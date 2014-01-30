class MakePermittedViewersIntArray < ActiveRecord::Migration
  def change
    remove_column :users, :permitted_viewers
    add_column :users, :permitted_viewers, :integer, array: true, default: []
  end
end
