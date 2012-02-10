require 'spec_helper'

describe MetaTagHelper do

  describe "#page_id" do
    it "defaults to empty string" do
      page_id.should == ""
    end

    it "accepts one argument and returns the page_id" do
      page_id("page-users").should == "page-users"
    end

    it "accepts more arguments and returns the page_id" do
      page_id("page-users", "page-view").should == "page-users page-view"
    end

    it "accepts zero arguments and returns the page_id" do
      page_id("page-users")
      page_id("page-views")
      page_id.should == "page-users page-views"
    end

    it "can be called multiple times" do
      page_id("page-users").should == "page-users"
      page_id("page-views").should == "page-users page-views"
    end
  end

end
