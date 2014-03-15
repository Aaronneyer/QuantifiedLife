class ChangePhotoDateToDatetime < ActiveRecord::Migration
  def change
    rename_column :photos, :date, :datetime
    change_column :photos, :datetime, :datetime
  end
end
