Factory.sequence(:name)  { |n| "user#{n}" }
Factory.sequence(:email) { |n| "user#{n}@domain.com" }

Factory.define :user do |user|
  user.name                  { Factory.next(:name) }
  user.email                 { Factory.next(:email) }
  user.password              { "secret" }
  user.password_confirmation { "secret" }
end