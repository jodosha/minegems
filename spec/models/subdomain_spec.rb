require 'spec_helper'

describe Subdomain do
  # before do
  #   @subdomain = Factory.create :subdomain
  # end

  specify { should have_many(:memberships).dependent(:destroy) }
  specify { should have_many(:users).through(:memberships) }
  specify { should have_one(:owner).through(:memberships) }

  specify { should validate_presence_of(:name) }
  # specify { should validate_uniqueness_of(:name) }

  describe "validations" do
    it "should validate presence of owner" do
      subdomain = Subdomain.new
      subdomain.should_not be_valid
      subdomain.errors[:base].should include("It should belong to an owner")
    end
  end
end
