# Load the Rails application.
require File.expand_path('../application', __FILE__)

config.middleware.use Rack::ForceDomain, ENV["DOMAIN"]

# Initialize the Rails application.
HappilyAdrift::Application.initialize!
