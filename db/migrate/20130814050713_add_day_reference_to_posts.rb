class AddDayReferenceToPosts < ActiveRecord::Migration
  def up
    add_column :posts, :day_id, :integer
    add_index :posts, :day_id
    remove_column :days, :post_id
  end

  def down
    add_column :days, :post_id, :integer
    add_index :days, :post_id
    remove_column :posts, :day_id
  end
end
