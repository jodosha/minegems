require 'spec_helper'

describe Version do
  before :each do
    @subdomain = Factory.create(:subdomain)
    @version   = Version.create_from_file(rubygem_file('test-0.0.0.gem'), @subdomain)
  end

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
  end

  it "should extract data from gemspec" do
    @version.number.should == "0.0.0"
    @version.should_not be_prerelease
    @version.platform.should == "ruby"
  end

  it "should set as a pre-release" do
    version = Version.create_from_file(rubygem_file('test-0.0.1.beta1.gem'), @subdomain)
    version.should be_prerelease
  end

  it "should be serializable as Gem::Version" do
    @version.to_gem_version.should == Gem::Version.new('0.0.0')
  end

  it "should be serializable for Gem indices" do
    @version.to_index.should == [ @version.rubygem.name, @version.to_gem_version, @version.platform ]
  end
end
