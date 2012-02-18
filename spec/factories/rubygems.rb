FactoryGirl.define do
  factory :rubygem do
    sequence(:name) { |n| "gem#{n}" }
    subdomain
  end
end


def rubygem_params(attributes = {})
  {
    'file' => rubygem_file('test-0.0.0.gem')
  }.merge(attributes)
end

def rubygem_file(name)
  Rack::Test::UploadedFile.new(::File.dirname(__FILE__) + "/gems/#{name}", nil, true)
end
