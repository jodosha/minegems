When /^I attach "([^"]*)"$/ do |rubygem|
  attach_file('gem_file', path_to_gem(rubygem))
end

When /^I create a new gem "([^"]*)"$/ do |rubygem|
  Rubygem.create_from_file(rubygem_file(rubygem))
end

Then /^a gem "([^"]*)" should exist$/ do |rubygem|
  Rubygem.by_name(rubygem).should_not be_empty
end

Then /^a version "([^"]*)" should exist for "([^"]*)" gem$/ do |version, rubygem|
  Rubygem.by_name(rubygem).first.version(version).should_not be_nil
end

Given /^a gem "([^"]*)"$/ do |rubygem|
  Factory.create(:rubygem, :file => rubygem_file(rubygem))
end

When /^I upgrade a gem "([^"]*)"$/ do |rubygem|
  Rubygem.create_from_file(rubygem_file(rubygem))
end

Then /^an unique "([^"]*)" gem should exist$/ do |rubygem|
  Rubygem.by_name(rubygem).size.should == 1
end

module RubygemsHelper
  def path_to_gem(rubygem)
    ::File.dirname(__FILE__) + "/../../spec/support/factories/gems/#{rubygem}"
  end
end

World(RubygemsHelper)