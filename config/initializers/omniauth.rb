Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '179208095616.apps.googleusercontent.com', '1mAB1Oc7BUfH-B0xra42W6Qe'
end
