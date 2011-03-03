Given /^an early bird registered with "([^"]*)"$/ do |email|
  Factory.create :early_bird, :email => email
end
