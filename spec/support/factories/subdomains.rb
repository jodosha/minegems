Factory.sequence(:subdomain_name) { |n| "subdomain#{n}" }

Factory.define :subdomain do |subdomain|
  subdomain.name { Factory.next(:subdomain_name) }
end
