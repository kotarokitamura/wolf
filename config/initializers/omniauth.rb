Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter,ResourceProperty.twitter_consumer_key,ResourceProperty.twitter_consumer_secret
  provider :facebook, ResourceProperty.facebook_app_id, ResourceProperty.facebook_app_secret, :scope => 'publish_actions,publish_stream,read_stream', :display => 'popup'
end
