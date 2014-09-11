source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

group :production, :staging do
	gem 'mysql2'
end

group :development, :test do
	gem 'sqlite3'
	gem 'sextant'
	gem 'capistrano', "3.1.0", group: :development
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use debugger
# gem 'debugger', group: [:development, :test]

#image upload
gem 'remotipart'
gem 'mini_magick'
gem 'carrierwave'

gem 'devise'
#after bundle: rails g rails_admin:install
gem 'rails_admin'
gem 'acts-as-taggable-on'
gem 'haml'
gem "select2-rails"

gem "aasm"

gem "rails-alertify"
gem 'kaminari'
gem 'wisper'

gem 'recaptcha', :require => "recaptcha/rails"

gem 'friendly_id', '~> 5.0.0'
gem 'babosa'

gem 'mailgun_rails'
#work with devise
gem 'cancan'
gem 'rolify'

gem 'whenever', :require => false

group :development do
  gem 'thin'
  gem 'meta_request'
  gem 'faker'
  gem 'populator'
  gem 'brakeman', :require => false
end


