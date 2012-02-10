require 'spec_helper'

describe User do

  subject { Factory.build(:user) }

  describe "associations" do
    it { should have_many(:memberships).dependent(:destroy) }
    it { should have_many(:subdomains).through(:memberships) }
  end

  describe "validations" do
    it "is valid with factory" do
      subject.should be_valid
    end

    describe ":name" do
      it { should validate_presence_of(:name) }
    end

    describe ":username" do
      it { should validate_presence_of(:username) }

      it "validates uniqueness" do
        subject = Factory.create(:user)
        subject.should validate_uniqueness_of(:username)
      end
    end

    describe ":email" do
      it "validates uniqueness" do
        subject = Factory.create(:user)
        subject.should validate_uniqueness_of(:email)
      end
    end
  end

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:email) }
  it { should allow_mass_assignment_of(:username) }
  it { should allow_mass_assignment_of(:login) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }
  it { should allow_mass_assignment_of(:remember_me) }
  it { should allow_mass_assignment_of(:registration_code) }
  it { should allow_mass_assignment_of(:deploy) }


  describe "create_with_subdomain!" do
    context "given a valid user" do
      let(:user) { Factory.build(:user) }

      context "and a valid subdomain" do
        let(:subdomain) { Factory.build(:subdomain).attributes }

        it "should create" do
          user.create_with_subdomain!(subdomain).should be_true
        end
      end

      context "and an invalid subdomain" do
        let(:subdomain) { Factory.build(:subdomain, :tld => "").attributes }

        it "should not create" do
          user.create_with_subdomain!(subdomain).should be_false
        end
      end
    end

    context "given an invalid user" do
      let(:user) { Factory.build(:user, :password => "") }

      context "and a valid subdomain" do
        let(:subdomain) { Factory.build(:subdomain).attributes }

        it "should not create" do
          user.create_with_subdomain!(subdomain).should be_false
        end
      end

      context "and an invalid subdomain" do
        let(:subdomain) { Factory.build(:subdomain, :name => "").attributes }

        it "should not create" do
          user.create_with_subdomain!(subdomain).should be_false
        end
      end
    end

    context "given an already existing record" do
      let(:user) { Factory(:user) }
      let(:subdomain) { Factory(:subdomain).attributes }

      it "should return false" do
        user.create_with_subdomain!(subdomain).should be_false
      end
    end
  end
end
