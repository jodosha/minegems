FactoryGirl.define do
  factory :user do
    sequence(:username)     { |n| "user#{n}" }
    name                    "Luca"
    email                   { "#{username}@example.com" }
    password                "secret"
    password_confirmation   "secret"

    # after_build do |u|
    #   Factory.create(:early_bird, :email => u.email, :code => u.registration_code)
    # end
  end
end


def create_user(email_and_password)
  email, password = email_and_password.split '/'
  Factory.create :user, :email => email, :password => password, :password_confirmation => password
end
