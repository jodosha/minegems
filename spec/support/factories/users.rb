Factory.sequence(:name)  { |n| "user#{n}" }
Factory.sequence(:email) { |n| "user#{n}@domain.com" }

Factory.define :user do |user|
  user.name                  { Factory.next(:name) }
  user.email                 { Factory.next(:email) }
  user.password              { "secret" }
  user.password_confirmation { "secret" }
end

def create_user(email_and_password)
  email, password = email_and_password.split '/'
  Factory.create :user, :email => email, :password => password, :password_confirmation => password
end