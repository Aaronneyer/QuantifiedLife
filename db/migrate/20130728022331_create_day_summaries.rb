class CreateDaySummaries < ActiveRecord::Migration
  def change
    create_table :day_summaries do |t|
      t.date :day
      t.string :summary
      t.references :post, index: true
      t.text :metadata

      t.timestamps
    end
  end
end
