When /^I attach "([^"]*)"$/ do |rubygem|
  attach_file('gem_file', path_to_gem(rubygem))
end

Given /^a gem "([^"]*)" by "([^"]*)"$/ do |rubygem, subdomain|
  subdomain = Subdomain.by_tld(subdomain).first
  Rubygem.create_version(rubygem_file(rubygem), subdomain)
end

Then /^"([^"]*)" gem should exist for "([^"]*)"$/ do |rubygem, subdomain|
  rubygem, version = rubygem.split '/'
  subdomain = Subdomain.by_tld(subdomain).first
  rubygems  = Rubygem.by_name(rubygem)

  rubygems.should_not be_empty
  rubygems.size.should == 1
  rubygems.first.version(version).should_not be_nil
  subdomain.rubygems.should include(rubygems.first)
end

module RubygemsHelper
  def path_to_gem(rubygem)
    ::File.dirname(__FILE__) + "/../../spec/support/factories/gems/#{rubygem}"
  end
end

World(RubygemsHelper)