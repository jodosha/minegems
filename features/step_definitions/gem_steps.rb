When /^I attach "([^"]*)"$/ do |rubygem|
  attach_file(:upload, create_gem(rubygem))
end