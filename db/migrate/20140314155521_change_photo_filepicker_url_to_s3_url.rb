class ChangePhotoFilepickerUrlToS3Url < ActiveRecord::Migration
  def change
    rename_column :photos, :filepicker_url, :s3_url
  end
end
