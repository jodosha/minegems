When /^I attach "([^"]*)"$/ do |rubygem|
  attach_file('gem_file', path_to_gem(rubygem))
end

When /^I create a new gem "([^"]*)"$/ do |rubygem|
  Factory.create(:rubygem, :file => rubygem_file(rubygem))
end

Then /^a gem "([^"]*)" should exist$/ do |rubygem|
  Rubygem.where(:name => rubygem).first.should_not be_nil
end

Then /^a version "([^"]*)" should exist for "([^"]*)" gem$/ do |version, rubygem|
  Rubygem.where(:name => rubygem).first.version(version).should_not be_nil
end

module RubygemsHelper
  def path_to_gem(rubygem)
    ::File.dirname(__FILE__) + "/../../spec/support/factories/gems/#{rubygem}"
  end
end

World(RubygemsHelper)