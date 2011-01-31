require 'spec_helper'

describe Rubygem do
  specify { should validate_presence_of(:name) }
  specify { should have_many(:versions) }
end
