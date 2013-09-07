class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :caption, type: String
  field :filepicker_url, type: String
  field :filename
  field :date, type: Date
  field :dropbox_path
  field :exif, type: Hash

  slug index: true do |doc|
    [doc.filename, doc.filepicker_url].reject.first.to_url
  end

  belongs_to :user, index: true

  index({ date: -1 })

  validates :filepicker_url, presence: true

  before_create :get_exif, :set_date
 
  def get_exif
    require 'open-uri'
    self.exif = {}
    begin
      temp_exif = EXIFR::JPEG.new(open(filepicker_url)).exif.to_hash
    rescue Errno::ENOENT
      return
    end
    temp_exif.each do |k,v|
      if k == :date_time
        self.exif[k] = v if v.is_a?(Time)
      elsif v.is_a?(EXIFR::TIFF::Orientation)
        self.exif[k] = v.to_i
      elsif v.is_a?(Rational)
        self.exif[k] = v.to_f
      elsif v.is_a?(Array)
        self.exif[k] = v.map { |x| x.is_a?(Rational) ? x.to_f : x }
      else
        self.exif[k] = v
      end
    end
  end

  def set_date
    self.exif = self.exif.with_indifferent_access
    if self.exif
      self.date ||= self.exif[:date_time_original]
      self.date ||= self.exif[:date_time]
      if self.exif[:gps_date_stamp]
        self.date ||= Date.strptime(self.exif[:gps_date_stamp], '%Y:%m:%d')
      end
      if self.dropbox_path
        begin
          self.date ||= Date.parse(File.basename(self.dropbox_path))
        rescue ArgumentError
        end
      end
    end
  end

  def day
    Day.where(date: date).first
  end

  class << self
    def fetch_db_photos(user_id)
      user = User.find(user_id)
      return unless user.dropbox_token
      db = DropboxClient.new(user.dropbox_token)
      fp = FilepickerAPI.new
      files = db.metadata('/Camera Uploads')['contents']
      files.select { |f| f['mime_type']=='image/jpeg' }.each do |file|
        if !user.photos.where(dropbox_path: file['path']).any?
          media = db.media(file['path'])
          result = fp.store({url: media['url']})
          Photo.create!(filepicker_url: result['url'],
                        dropbox_path: file['path'],
                        filename: File.basename(file['path']),
                        user_id: user_id)
        end
      end
    end
  end
end
