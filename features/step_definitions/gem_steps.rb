When /^I attach "([^"]*)"$/ do |rubygem|
  attach_file('gem_file', path_to_gem(rubygem))
end

module RubygemsHelper
  def path_to_gem(rubygem)
    ::File.dirname(__FILE__) + "/../../spec/support/factories/gems/#{rubygem}"
  end
end

World(RubygemsHelper)