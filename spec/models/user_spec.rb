require 'spec_helper'

describe User do
  before do
    @user = Factory.create :user
  end

  # Associations
  specify { should have_many(:memberships).dependent(:destroy) }
  specify { should have_many(:subdomains).through(:memberships) }

  # Validations
  specify { should validate_presence_of(:name) }
  specify { should validate_presence_of(:username) }
  specify { should validate_uniqueness_of(:email) }
  specify { should validate_uniqueness_of(:username) }

  it "should have accessible attributes" do
    @user.accessible_attributes.should == [ :name, :email, :username, :login, :password, :password_confirmation, :remember_me, :registration_code, :deploy ]
  end

  describe "create_with_subdomain!" do
    context "given a valid user" do
      let(:user) { Factory.build(:user) }

      context "and a valid subdomain" do
        let(:subdomain) { build_subdomain_params }

        it "should create" do
          user.create_with_subdomain!(subdomain).should be_true
        end
      end

      context "and an invalid subdomain" do
        let(:subdomain) { build_subdomain_params :tld => "" }

        it "should not create" do
          user.create_with_subdomain!(subdomain).should be_false
        end
      end
    end

    context "given an invalid user" do
      let(:user) { Factory.build(:user, :password => "") }

      context "and a valid subdomain" do
        let(:subdomain) { build_subdomain_params }

        it "should not create" do
          user.create_with_subdomain!(subdomain).should be_false
        end
      end

      context "and an invalid subdomain" do
        let(:subdomain) { build_subdomain_params :name => "" }

        it "should not create" do
          user.create_with_subdomain!(subdomain).should be_false
        end
      end
    end

    context "given an already existing record" do
      let(:user) { @user }
      let(:subdomain) { Factory.build(:subdomain) }

      it "should return false" do
        @user.create_with_subdomain!(subdomain).should be_false
      end
    end
  end
end
