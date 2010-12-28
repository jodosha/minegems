require 'spec_helper'

describe Membership do
  specify { should belong_to(:subdomain) }
  specify { should belong_to(:user) }
end
