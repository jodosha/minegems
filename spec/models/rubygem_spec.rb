require 'spec_helper'

describe Rubygem do
  specify { should have_many(:versions).dependent(:destroy) }
  specify { should belong_to(:subdomain) }
  specify { should validate_presence_of(:name) }
  specify { should validate_presence_of(:subdomain_id) }

  it "should validate uniqueness of name" do
    rubygem = Factory.create(:rubygem)
    rubygem.should validate_uniqueness_of(:name)
  end
end
