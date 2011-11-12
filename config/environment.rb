# Config
GAPPS_DOMAIN = 'your_google_apps_domain.com'
GAPPS_CONSUMER_KEY = GAPPS_DOMAIN
GAPPS_CONSUMER_SECRET = 'YOUR_KEY_SECRET'
GAPPS_REQUESTOR_ID = 'some-admin-of@your_google_apps_domain.com'

HOME_INITIAL_POSTS = 10

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Somos::Application.initialize!
