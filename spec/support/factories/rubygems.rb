Factory.sequence :rubygem_name do |n|
  "gem#{n}"
end

Factory.define :rubygem do |f|
  f.name      { Factory.next(:rubygem_name) }
  f.subdomain { |a| a.association(:subdomain) }
end

def rubygem_params(attributes = {})
  {
    'file' => rubygem_file('test-0.0.0.gem')
  }.merge(attributes)
end

def rubygem_file(name)
  ::File.open(::File.dirname(__FILE__) + "/gems/#{name}" )
end