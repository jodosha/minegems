Factory.sequence(:early_bird_email) { |n| "user#{n}@domain.com" }

Factory.define :early_bird do |early_bird|
  early_bird.email { Factory.next(:early_bird_email) }
end