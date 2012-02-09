Factory.define :user do |user|
  user.name                   { "Luca" }
  user.sequence(:email)       { |n| "user#{n}@domain.com" }
  user.sequence(:username)    { |n| "username#{n}" }
  user.password               { "secret" }
  user.password_confirmation  { "secret" }
  user.sequence(:registration_code) { |n| n }

  user.after_build do |u|
    Factory.create(:early_bird, :email => u.email, :code => u.registration_code)
  end
end

def create_user(email_and_password)
  email, password = email_and_password.split '/'
  Factory.create :user, :email => email, :password => password, :password_confirmation => password
end
