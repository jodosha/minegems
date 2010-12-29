Factory.sequence(:subdomain_tld) { |n| "subdomain#{n}" }

Factory.define :subdomain do |subdomain|
  subdomain.tld  { Factory.next(:subdomain_tld) }
  subdomain.name { "Subdomain" }
end

def build_subdomain_params(options = {})
  Factory.build(:subdomain, options).attributes
end