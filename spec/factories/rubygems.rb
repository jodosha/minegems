Factory.define :rubygem do |f|
  f.sequence(:name) { |n| "gem#{n}" }
  f.subdomain { |a| a.association(:subdomain) }
end

def rubygem_params(attributes = {})
  {
    'file' => rubygem_file('test-0.0.0.gem')
  }.merge(attributes)
end

def rubygem_file(name)
  Rack::Test::UploadedFile.new(::File.dirname(__FILE__) + "/gems/#{name}", nil, true)
end
