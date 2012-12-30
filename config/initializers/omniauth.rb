Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV[FACEBOOK_API_KEY], ENV[FACEBOOK_SECRET], {:client_options => {:ssl =>  {:verify => false}},:scope => 'email, publish_stream,offline_access', :display => 'popup'}
end