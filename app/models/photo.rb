class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Slug

  field :caption, type: String
  slug :caption
  field :filepicker_url, type: String
  field :date, type: Date
  field :exif, type: Hash

  index({ date: -1 })

  validates :filepicker_url, presence: true

  before_save :get_exif

  def get_exif
    require 'open-uri'
    self.exif = {}
    EXIFR::JPEG.new(open(filepicker_url)).exif.to_hash.each do |k,v|
      if v.is_a?(EXIFR::TIFF::Orientation)
        self.exif[k] = v.to_i
      elsif v.is_a?(Rational)
        self.exif[k] = v.to_f
      else
        self.exif[k] = v
      end
    end
    self.date = self.exif[:date_time_original]
  end

  def day
    Day.where(date: date).first
  end
end
