Factory.define :subdomain do |f|
  f.sequence(:tld) { |n| "subdomain#{n}" }
  f.after_build do |s|
    s.name = s.tld.classify
  end
end
