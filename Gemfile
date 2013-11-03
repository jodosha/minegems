source 'http://rubygems.org'

gem 'rails', '3.2.15'
gem 'jquery-rails', '~> 2.0.1'

# I dont like RCs for unstable projects but ran into this Bundler conflict.
#
# Bundler could not find compatible versions for gem "railties":
#   In Gemfile:
#       rails (= 3.2.1) ruby depends on
#         railties (= 3.2.1) ruby
#
#       jquery-rails (~> 2.0.0) ruby depends on
#         railties (3.2.2.rc1)

gem 'airbrake',              '~> 3.0.0'
gem 'babosa',                '~> 0.3.6'
gem 'bcrypt-ruby',           '~> 3.0.0', :require => 'bcrypt'
gem 'devise',                  '~> 1.1'
gem 'redis',                 '~> 2.2.2'
gem 'resque',               '~> 1.20.0'
gem 'fog',                   '~> 0.9.0'
gem 'sinatra',               '~> 1.3.2'
gem 'heroku',               '~> 2.20.1'
gem 'pg',                   '~> 0.17.0'
gem 'bson_ext',                 '1.6.0'
gem 'mongo',                    '1.6.0'
gem 'mongo_ext',               '0.19.3'
gem 'carrierwave',              '0.5.4' # FIXME Patched, can't update. Can safely upgrade when we'll move away from Heroku
gem 'devise_aes_encryptable',   '0.2.3'
gem 'resque-heroku-autoscaler', '0.2.3' # Not sure if still works

group :assets do
  gem 'sass-rails',   '~> 3.2.4'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier',     '~> 1.2.3'
end

group :development do
  gem 'foreman', '~> 0.40.0'
end

group :test do
  # gem 'cucumber-rails'
  gem 'capybara',         '~> 1.1.2'
  gem 'database_cleaner', '~> 0.7.1'
  gem 'shoulda-matchers', '~> 1.0.0'
  gem 'email_spec',       '~> 1.2.1'
end

group :development, :test do
  gem 'factory_girl_rails', '~> 1.7.0'
  gem 'rspec-rails',        '~> 2.8.1'
  gem 'ruby-debug19', require: false
end
