Then /^I should see error messages$/ do
  page.body.should match(/error(s)? prohibited/m)
end

# Paths

Then /^I should see the "([^"]*)" login page$/ do |subdomain|
  page.body.should match(%r{#{subdomain}})
  page.body.should match(/login/)
end

When /^I visit the subdomained "(.*)" under "(.*)"$/ do |path, subdomain|
  host = "#{subdomain}.#{$host}:#{$port}"
  case path
  when /signup page/
    visit new_user_registration_url(:host => host)
  else
    raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
      "Now, go and add a mapping in #{__FILE__}"
  end
end

# Users

Given /^An user signed up with "(.*)" name$/ do |name|
  Factory.create :user, :name => name
end

Given /^I signed up with "(.*)"$/ do |email_and_password|
  create_user(email_and_password)
end

Given /^I signed in with "(.*)"$/ do |email_and_password|
  email, password = email_and_password.split '/'
  user = create_user(email_and_password)

  visit new_user_session_path
  fill_in 'Email',    :with => email
  fill_in 'Password', :with => password

  click_button 'Sign in'
end

# Domains

Given /^A subdomain with "(.*)" tld$/ do |tld|
  Factory.create(:subdomain, :tld => tld)
end

# Session

Then /^I should be signed in$/ do
  pending
end

# Emails

Then /^a confirmation message should be sent to "(.*)"$/ do |email|
  user = User.find_by_email(email)
  sent = ActionMailer::Base.deliveries.last
  sent.to.should == [user.email]
  sent.subject.should match(/confirm/i)
  user.confirmation_token.should_not be_blank
  sent.body.should match(/#{user.confirmation_token}/)
end

When /^I follow the confirmation link sent to "(.*)"$/ do |email|
  user = User.find_by_email(email)
  visit user_confirmation_path(:user_id            => user,
                               :confirmation_token => user.confirmation_token)
end
