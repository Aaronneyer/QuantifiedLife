class AddImpactScoreOnDaySummaries < ActiveRecord::Migration
  def change
    add_column :day_summaries, :impact, :integer
  end
end
