#require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  puts ENV['GOOGLE_KEY']
  puts "Chido"
  puts ENV.inspect
  provider :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], {approval_prompt: ''}
end
