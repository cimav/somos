# Config
GAPPS_DOMAIN = 'your-domain.com'
GAPPS_CONSUMER_KEY = GAPPS_DOMAIN
GAPPS_CONSUMER_SECRET = 'secret'
GAPPS_REQUESTOR_ID = 'admin@your-domain.com'

HOME_INITIAL_POSTS = 5

SITE_NAME = 'SOMOS'


# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Somos::Application.initialize!
