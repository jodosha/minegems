source 'http://rubygems.org'

gem 'bundler', '1.0.10'
gem 'rails', '3.0.5'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'devise'
gem 'babosa'
gem 'redis', '~> 2.1.1'
gem 'bson_ext', '1.2.4'
gem 'mongo', '1.2.4'
gem 'mongo_ext'
gem 'fog'
gem 'carrierwave'
gem 'resque'
gem 'sinatra'
gem 'devise_aes_encryptable'

gem 'rspec-rails', '~> 2.3.1', :group => [ :development, :test ]
gem 'ruby-debug19',            :group => [ :development, :test ]

group :development do
  gem 'mysql2'
  gem 'heroku'
end

group :test do
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'email_spec'
end

group :production do
  gem 'pg'
end