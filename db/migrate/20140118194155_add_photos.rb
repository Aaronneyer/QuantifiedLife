class AddPhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :caption
      t.string :filepicker_url
      t.string :filename
      t.date :date
      t.string :dropbox_url
      t.json :exif
    end
  end
end
