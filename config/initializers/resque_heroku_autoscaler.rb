require 'resque/plugins/resque_heroku_autoscaler'

Resque::Plugins::HerokuAutoscaler.config do |c|
  c.heroku_user = ENV['HEROKU_USERNAME']
  c.heroku_pass = ENV['HEROKU_PASSWORD']
  c.heroku_app  = ENV['APP_NAME']
end