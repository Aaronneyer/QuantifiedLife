class Photo < ActiveRecord::Base

  belongs_to :user

  validates :s3_url, presence: true

  before_create :set_date
 
  def exif_file=(photo_file)
    self.exif = {}
    begin
      temp = EXIFR::JPEG.new(photo_file).exif
      return unless temp
      temp_exif = temp.to_hash
    rescue Errno::ENOENT, EXIFR::MalformedJPEG
      return
    end
    # JSON doesn't like rationals very much, so this fixes it up a bit
    temp_exif.each do |k,v|
      if v.is_a?(Rational)
        self.exif[k] = v.to_json
      elsif v.is_a?(Array)
        self.exif[k] = v.map { |x| x.is_a?(Rational) ? x.to_json : x }
      else
        self.exif[k] = v
      end
    end
  end

  def set_date
    # Try and get the date from exif, in the various fields it would be stored in
    if self.exif
      self.exif = self.exif.with_indifferent_access
      self.date ||= self.exif[:date_time_original]
      self.date ||= self.exif[:date_time]
      if self.exif[:gps_date_stamp]
        self.date ||= Date.strptime(self.exif[:gps_date_stamp], '%Y:%m:%d')
      end
    end
    # If we can't get it from exif, try and get it from filename
    if self.dropbox_path
      begin
        self.date ||= Date.parse(File.basename(self.dropbox_path))
      rescue ArgumentError
      end
    end
    # Fall back to the date it was uploaded
    self.date ||= created_at.to_date
  end

  def day
    Day.where(date: date).first
  end

  class << self
    def fetch_db_photos(user_id)
      require 'open-uri'
      user = User.find(user_id)
      return unless user.dropbox_token
      db = DropboxClient.new(user.dropbox_token)
      files = db.metadata('/Camera Uploads')['contents']
      files.select { |f| f['mime_type']=='image/jpeg' }.each do |file|
        unless user.photos.where(dropbox_path: file['path'], user_id: user_id).any?
          media = db.media(file['path'])
          s3 = AWS::S3.new
          filename = File.basename(file['path'])
          f = open(media['url'])
          result = s3.buckets['quantifiedlife'].objects[filename].write(data: f)
          f.rewind
          photo = Photo.create!(s3_url: result.public_url.to_s,
                        dropbox_path: file['path'],
                        filename: filename,
                        user_id: user_id,
                        exif_file: f)
          puts result.public_url
        end
      end
    end
  end
end
