require 'spec_helper'

describe Rubygem do

  subject { Factory.build(:rubygem) }

  describe "associations" do
    it { should belong_to(:subdomain) }
    it { should have_many(:versions).dependent(:destroy) }
  end

  describe "validations" do
    it "is valid with factory" do
      subject.should be_valid
    end

    describe ":name" do
      it { should validate_presence_of(:name) }

      it "validates uniqueness" do
        subject = Factory.create(:rubygem)
        subject.should validate_uniqueness_of(:name)
      end
    end

    describe ":subdomain_id" do
      it { should validate_presence_of(:subdomain_id) }
    end
  end
end
