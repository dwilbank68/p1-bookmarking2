source 'https://rubygems.org'

gem 'rails', '4.1.4'

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.1.0'
  gem 'capybara', '~> 2.3.0'
  gem 'selenium-webdriver'
  gem 'awesome_print'
  #gem 'pry-rails'
end

group :development do
  gem 'sqlite3'
  gem 'quiet_assets'
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails', '~> 4.0'
end

gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass', '~> 3.1.1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

gem 'faker'
gem 'devise'
gem 'figaro'
gem 'tzinfo-data', platforms: [:mingw, :mswin]
gem 'pundit'
#gem 'redcarpet'
#gem 'carrierwave'
#gem 'mini_magick'
#gem 'fog'
gem 'will_paginate', '~> 3.0.5'

gem 'hirb'

gem 'newrelic_rpm'
gem 'i18n', '~> 0.6.11' # rails g devise:install wouldn't work without it
gem 'omniauth-facebook'