class CreateNewdays < ActiveRecord::Migration
  def change
    create_table :newdays do |t|
      t.date :date
      t.string :headline
      t.text :summary
      t.string :start_location
      t.string :end_location
      t.integer :impact
      t.json :extra_info
      t.json :moves_storyline
      t.json :moves_summary
      t.references :user

      t.timestamps
    end
  end
end
