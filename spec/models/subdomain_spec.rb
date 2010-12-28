require 'spec_helper'

describe Subdomain do
  # before do
  #   @subdomain = Factory.create :subdomain
  # end

  specify { should have_many(:memberships).dependent(:destroy) }
  specify { should have_many(:users).through(:memberships) }

  specify { should validate_presence_of(:name) }
  # specify { should validate_uniqueness_of(:name) }
end
