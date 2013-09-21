module MovesHelper
  def redirect_uri
    uri = URI.parse(request.url)
    uri.path = '/moves/callback'
    uri.query = nil
    uri.to_s
  end
end
