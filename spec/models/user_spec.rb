require 'spec_helper'

describe User do
  before do
    @user = Factory.create :user
  end

  specify { should have_many(:memberships).dependent(:destroy) }
  specify { should have_many(:subdomains).through(:memberships) }

  specify { should validate_presence_of(:name) }
  specify { should validate_uniqueness_of(:name) }
  specify { should validate_uniqueness_of(:email) }

  it "should have accessible attributes" do
    @user.accessible_attributes.should == [ :name, :email, :password, :password_confirmation, :remember_me ]
  end
end
