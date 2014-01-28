source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

group :development, :test do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

gem 'twitter', '>= 4.0.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby
# gem 'less-rails'
# gem 'twitter-bootstrap-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem "omniauth"
gem 'omniauth-twitter'

group :development do
  gem "better_errors" # These two are just for debugging
  gem "binding_of_caller"
end

group :development do
  gem 'rspec-rails'
  gem "guard-rspec"
end

group :test do
  gem 'simplecov', require: false
  gem 'factory_girl_rails'
end

gem 'figaro'

gem 'tumblr_client', '= 0.8.2'

gem 'feedzirra'
gem 'debugger'
