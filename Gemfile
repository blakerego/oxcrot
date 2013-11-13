source 'https://rubygems.org'

gem 'rails', '4.0.0'

gem 'pg'

group :production do
  gem 'thin'  
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

gem "font-awesome-rails"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem "haml-rails"
gem "simple_form"
gem 'awesome_print'
gem 'debugger'
gem 'pry'
gem 'better_errors'
gem 'binding_of_caller'

gem 'nokogiri'
gem 'faraday'
gem "flickraw", "~> 0.9.6"

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'newrelic_rpm'

gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
  gem 'rb-fsevent', :require => false if RUBY_PLATFORM =~ /darwin/i
  gem 'rspec-rails'
  gem 'guard-rspec'
end

