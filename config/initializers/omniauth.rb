Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '449873258406517', 'ba59747f47b4a2e38bddf04f15335e7e',
    :scope => 'email, publish_stream', :display => 'popup'
end