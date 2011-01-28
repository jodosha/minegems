require 'spec_helper'

describe Version do
  specify { should belong_to(:rubygem) }
end
