Given /^an early bird registered with "([^"]*)"$/ do |email_and_code|
  email, code = email_and_code.split '/'
  Factory.create :early_bird, :email => email, :code => code
end

When /^I send the registration code for "([^"]*)"$/ do |email_and_code|
  email, code = email_and_code.split '/'
  beta = EarlyBird.where(:email => email).limit(1).first
  Beta.registration_code(beta).deliver
end

Then /^I should receive an email at "([^"]*)"$/ do |email|
  unread_emails_for(email).size.should == 1
end
