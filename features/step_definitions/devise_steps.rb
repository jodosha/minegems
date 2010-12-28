Then /^I should see error messages$/ do
  page.body.should match(/error(s)? prohibited/m)
end

# Users

Given /^An user signed up with "(.*)" name$/ do |name|
  User.create!(
    :name                  => name,
    :email                 => "user@person.com",
    :password              => "password",
    :password_confirmation => "password",
  )
end

Given /^I signed up with "(.*)"$/ do |email_and_password|
  email, password = email_and_password.split '/'

  User.create!(
    :name                  => "user",
    :email                 => email,
    :password              => password,
    :password_confirmation => password,
  )
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
