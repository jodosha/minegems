FactoryGirl.define do
  factory :rubygem do
    sequence(:name) { |n| "gem#{n}" }
    subdomain
  end
end


def rubygem_file(name)
  Rack::Test::UploadedFile.new(::File.dirname(__FILE__) + "/gems/#{name}", nil, true)
end
