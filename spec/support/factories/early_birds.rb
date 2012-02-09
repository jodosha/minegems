Factory.define :early_bird do |f|
  f.sequence(:email) { |n| "user#{n}@domain.com" }
end
