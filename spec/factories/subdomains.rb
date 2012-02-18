FactoryGirl.define do
  factory :subdomain do
    sequence(:tld) { |n| "subdomain#{n}" }
    name { tld.titleize }
  end
end
