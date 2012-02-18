# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

$host = 'lvh.me'
$port = 60000

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

unless defined?(SPEC_ROOT)
  SPEC_ROOT = File.expand_path("../", __FILE__)
end

RSpec.configure do |config|
  config.mock_with :rspec
  config.render_views
  config.use_transactional_fixtures = true

  config.include Devise::TestHelpers, :type => :controller
  config.extend  DeviseMacros,        :type => :controller

  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers
end
