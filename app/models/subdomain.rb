class Subdomain < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_one  :owner, :through => :memberships, :source => :user, :conditions => "memberships.role = 'owner'"

  has_friendly_id :name, :use_slug => true, :strip_non_ascii => true
  validates_uniqueness_of :name, :case_sensitive => false
  validates_presence_of   :name
  validate :presence_of_owner

  private
    def presence_of_owner
      if self.owner.nil?
        errors[:base] << "It should belong to an owner"
      end
    end
end
