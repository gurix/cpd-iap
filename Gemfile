source 'https://rubygems.org'

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.6'
# gem 'rails', path: '../rails'

# Use Puma as the app server
gem 'puma', '~> 4.3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Sass-powered version of Bootstrap 3
gem 'bootstrap-sass', '~> 3.4.1'
# Use slim as default language
gem 'slim-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Library that generates fake data.
gem 'faker'

# provides the Font-Awesome web fonts and stylesheets as a Rails engine for use with the asset pipeline.
gem 'font-awesome-rails'

# This gem hooks up your Rails application with Roadie to help you generate HTML emails.
gem 'roadie-rails', '~> 1.0'

# A fixtures replacement with a straightforward definition syntax
gem 'factory_bot_rails'

# Collecting Locale data for Ruby on Rails
gem 'rails-i18n'

# Adds support for multiparameter fields to mongoid 4.x series.
gem 'mongoid-sadstory'

# Rails app configuration using ENV
gem 'dotenv-rails'

# Simple Form aims to be as flexible as possible while helping you with powerful components to create your forms.
gem 'simple_form'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Mongoid Database adapter
gem 'mongoid', '~> 6.0.0'

# Validates email addresses
gem 'valid_email'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri

  # Pry is a powerful alternative to the standard IRB shell for Ruby
  gem 'pry'

  # Causes rails console to open pry
  gem 'pry-rails'

  # Testing framework for Rails 3.x, 4.x and 5.0.
  gem 'rspec-rails', '~> 3.5'

  # RSpec matches for Mongoid models, including association and validation matchers
  gem 'mongoid-rspec'

  # Acceptance test framework for web applications
  gem 'capybara'
  gem 'capybara-screenshot'

  # RSpec::CollectionMatchers lets you express expected outcomes on collections of an object in an example
  gem 'rspec-collection_matchers'

  # A javascript driver for Capybara
  gem 'selenium-webdriver'
  gem 'webdrivers'

  # Helper class for launching cross-platform applications in a fire and forget manner.
  gem 'launchy'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0.5'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  # gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
