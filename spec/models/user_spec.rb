require 'spec_helper'

describe User do
  it "should have accessible attributes" do
    @user.accessible_attributes.should == [ :name, :email, :password, :password_confirmation, :remember_me ]
  end
end
