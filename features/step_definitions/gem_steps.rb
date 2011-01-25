When /^I attach "([^"]*)"$/ do |rubygem|
  attach_file('gem_file', create_gem(rubygem))
end

module RubygemsHelper
  def create_gem(rubygem)
    
  end
end

World(RubygemsHelper)