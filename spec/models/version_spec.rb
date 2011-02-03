require 'spec_helper'

describe Version do
  specify { should belong_to(:rubygem) }
  specify { should validate_presence_of(:file) }
  specify { should validate_presence_of(:number) }
  specify { should validate_presence_of(:platform) }

  context "given a valid gemspec" do
    let(:version) { Version.new(:file => rubygem_file('test-0.0.0.gem')) }

    it "should be valid" do
      version.should be_valid
    end
  end

  context "given an invalid gemspec" do
    context "not a gemspec" do
      let(:version) { Version.new(:file => rubygem_file('invalid-0.0.0.gem')) }

      it "should be invalid" do
        version.should_not be_valid
        version.errors[:gemspec].should == ["is empty"]
      end
    end

    # %w(name version summary require_paths).each do |attr|
    #   context "with missing #{attr}" do
    #     let(:version) { version_with_invalid_spec(attr => nil) }
    # 
    #     it "should be invalid" do
    #       version.should_not be_valid
    #       version.errors[:gemspec].should include("#{attr} is required")
    #     end
    #   end
    # end
  end

  it "should extract data from gemspec" do
    version = Version.create(:file => rubygem_file('test-0.0.0.gem'))
    version.number.should == "0.0.0"
    version.should_not be_prerelease
    version.platform.should == "ruby"
  end

  it "should set as a pre-release" do
    version = Version.create(:file => rubygem_file('test-0.0.1.beta1.gem'))
    version.should be_prerelease
  end
end
