require 'spec_helper'

describe Rubygem do
  specify { should validate_presence_of(:file) }

  context "given a valid gemspec" do
    let(:rubygem) { Rubygem.new(:file => rubygem_file('test-0.0.0.gem')) }

    it "should be valid" do
      rubygem.should be_valid
    end
  end

  context "given an invalid gemspec" do
    context "not a gemspec" do
      let(:rubygem) { Rubygem.new(:file => rubygem_file('invalid-0.0.0.gem')) }

      it "should be invalid" do
        rubygem.should_not be_valid
        rubygem.errors[:gemspec].should == ["is empty"]
      end
    end

    %w(name version summary require_paths).each do |attr|
      context "missing #{attr}" do
        let(:rubygem) { rubygem_with_invalid_spec(attr => nil) }

        it "should be invalid" do
          rubygem.should_not be_valid
          rubygem.errors[:gemspec].should include("#{attr} is required")
        end
      end
    end
  end
end
