Factory.sequence(:email)    { |n| "user#{n}@domain.com" }
Factory.sequence(:username) { |n| "username#{n}" }
Factory.sequence(:registration_code) { |n| n }

Factory.define :user do |user|
  user.name                  { "Luca" }
  user.email                 { Factory.next(:email) }
  user.username              { Factory.next(:username) }
  user.password              { "secret" }
  user.password_confirmation { "secret" }
  user.registration_code     { Factory.next(:registration_code) }

  user.after_build do |u|
    Factory.create(:early_bird, :email => u.email, :code => u.registration_code)
  end
end

def create_user(email_and_password)
  email, password = email_and_password.split '/'
  Factory.create :user, :email => email, :password => password, :password_confirmation => password
end
