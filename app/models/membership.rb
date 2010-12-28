class Membership < ActiveRecord::Base
  belongs_to :subdomain
  belongs_to :user
end
