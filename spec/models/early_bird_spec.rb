require 'spec_helper'

describe EarlyBird do
  before :each do
    @early_bird = Factory.create(:early_bird)
  end

  # specify { should validate_presence_of(:email, :message => "We need an email address to keep in touch with you.")}
  # specify { should validate_uniqueness_of(:email, :message => "Sorry, but you have already subscribed with this email address.") }
  # specify { should validate_format_of(:email, ;).message("We need a valid email address to keep in touch with you.").with(/\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i) }
end
