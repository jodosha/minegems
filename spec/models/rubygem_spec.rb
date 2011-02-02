require 'spec_helper'

describe Rubygem do
  specify { should have_many(:versions) }
  specify { should belong_to(:subdomain) }
  specify { should validate_presence_of(:name) }
  specify { should validate_presence_of(:subdomain_id) }
end
