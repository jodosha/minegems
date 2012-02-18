FactoryGirl.define do
  factory :early_bird do
    sequence(:email) { |n| "user#{n}@domain.com" }
  end
end
