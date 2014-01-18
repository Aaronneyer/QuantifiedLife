class AddLocationToUser < ActiveRecord::Migration
  def change
    # JANK: Will fix once I get arrays working
    add_column :users, :location_string, :string, default: ''
  end
end
