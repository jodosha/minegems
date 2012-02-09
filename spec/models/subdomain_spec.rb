#encoding: utf-8
require 'spec_helper'

describe Subdomain do

  subject { Factory.build(:subdomain) }

  describe "associations" do
    it { should have_many(:memberships).dependent(:destroy) }
    it { should have_many(:users).through(:memberships) }
    it { should have_many(:rubygems).dependent(:destroy) }
    it { should have_many(:versions).through(:rubygems) }
    it { should have_one(:deploy_user).through(:memberships) } # .source(:user).conditions(["role = 'deploy'"])
  end

  describe "validations" do
    it "is valid with factory" do
      subject.should be_valid
    end

    describe ":name" do
      it { should validate_presence_of(:name) }
      it { should ensure_length_of(:name).is_at_most(64) }
    end

    describe ":tld" do
      let(:subdomain) { Factory.build :subdomain, :tld => tld }

      it { should validate_presence_of(:tld) }
      it { should ensure_length_of(:tld).is_at_most(64) }

      it "validates uniqueness" do
        subject = Factory.create(:subdomain)
        subject.should validate_uniqueness_of(:tld)
      end

      context "given an ASCII string" do
        let(:tld) { "sushistar" }

        it "is valid" do
          subdomain.should be_valid
        end
      end

      context "given a non-ASCII string" do
        let(:tld) { "寿司の星" }

        it "is not valid" do
          subdomain.should_not be_valid
        end
      end
    end
  end

  it { should allow_mass_assignment_of(:tld) }
  it { should allow_mass_assignment_of(:name) }

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
