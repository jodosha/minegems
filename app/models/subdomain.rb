class Subdomain < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships

  validates_uniqueness_of :tld, :case_sensitive => false
  validates_presence_of   :tld, :name
  validates :tld, :ascii => true
end
