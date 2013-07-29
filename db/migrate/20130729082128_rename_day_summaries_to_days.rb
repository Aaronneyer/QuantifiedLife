class RenameDaySummariesToDays < ActiveRecord::Migration
  def change
    rename_table :day_summaries, :days
    rename_column :days, :day, :date
  end
end
