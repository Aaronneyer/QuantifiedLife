class FilepickerAPI
  include HTTParty
  base_uri 'www.filepicker.io'

  def initialize
    @api_key = ENV['FILEPICKER_API_KEY']
  end

  def store(options)
    self.class.post("/api/store/S3?key=#{@api_key}", { body: options })
  end
end
