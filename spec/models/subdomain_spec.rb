#encoding: utf-8
require 'spec_helper'

describe Subdomain do
  before do
    @subdomain = Factory.create :subdomain
  end

  specify { should have_many(:memberships).dependent(:destroy) }
  specify { should have_many(:users).through(:memberships) }

  specify { should validate_uniqueness_of(:tld) }
  specify { should validate_presence_of(:tld) }
  specify { should validate_presence_of(:name) }

  describe "tld validation" do
    let(:subdomain) { Factory.build :subdomain, :tld => tld}

    context "given an ASCII string" do
      let(:tld) { 'sushistar' }

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
end
