class CreateNewgithubs < ActiveRecord::Migration
  def change
    create_table :newgithubs do |t|
      t.json :info

      t.timestamps
    end
  end
end
