#encoding: utf-8
require 'spec_helper'

describe Subdomain do
  before do
    @subdomain = Factory.create :subdomain
  end

  # Associations
  specify { should have_many(:memberships).dependent(:destroy) }
  specify { should have_many(:users).through(:memberships) }
  specify { should have_one(:deploy_user).through(:memberships) } # .source(:user).conditions(["role = 'deploy'"])
  specify { should have_many(:rubygems).dependent(:destroy) }

  # Validations
  specify { should validate_uniqueness_of(:tld) }
  specify { should validate_presence_of(:tld) }
  specify { should validate_presence_of(:name) }
  specify { should ensure_length_of(:name).is_at_most(64) }
  specify { should ensure_length_of(:tld).is_at_most(64) }

  it "should have accessible attributes" do
    @subdomain.accessible_attributes.should == [ :tld, :name ]
  end

  describe "tld validation" do
    let(:subdomain) { Factory.build :subdomain, :tld => tld}

    context "given an ASCII string" do
      let(:tld) { "sushistar" }

      it "should be valid" do
        subdomain.should be_valid
      end
    end

    context "given a non-ASCII string" do
      let(:tld) { "寿司の星" }

      it "should not be valid" do
        subdomain.should_not be_valid
      end
    end
  end

  describe "after create" do
    it "should create a deploy user" do
      subdomain = Factory.build(:subdomain)
      lambda {
        subdomain.save
      }.should change(User, :count)

      subdomain.deploy_user.should == User.find_by_email("#{subdomain.tld}@minege.ms")
    end
  end
end
