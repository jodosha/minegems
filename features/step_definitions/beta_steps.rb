Given /^an early bird registered with "([^"]*)"$/ do |email_and_code|
  email, code = email_and_code.split '/'
  Factory.create :early_bird, :email => email, :code => code
end
