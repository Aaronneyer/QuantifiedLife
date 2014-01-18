class CreateNewposts < ActiveRecord::Migration
  def change
    create_table :newposts do |t|
      t.string :title
      t.text :body
      t.date :date
      t.integer :impact
      t.string :tags
      t.references :user

      t.timestamps
    end
  end
end
