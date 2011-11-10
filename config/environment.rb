# Config
GAPPS_DOMAIN = 'your-google-apps-domain.com'
GAPPS_CONSUMER_KEY = GAPPS_DOMAIN
GAPPS_CONSUMER_SECRET = 'SECRET-KEY'
GAPPS_REQUESTOR_ID = 'admin-user@your-google-apps-domain.com'

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Somos::Application.initialize!
