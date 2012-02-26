FactoryGirl.define do
  factory :version do
    file      { Rails.root.join("spec/factories/gems/test-0.0.0.gem").open }
    rubygem
  end
end
