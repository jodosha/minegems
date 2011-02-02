class Subdomain < ActiveRecord::Base
  attr_accessible :tld, :name

  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :rubygems, :dependent => :destroy

  validates_uniqueness_of :tld, :case_sensitive => false
  validates_length_of     :tld, :name, :maximum => 64
  validates_presence_of   :tld, :name
  validates :tld, :ascii => true

  before_validation :transform_tld

  scope :by_tld, lambda { |tld|
    where("tld = ?", tld)
  }

  def self.search(query)
    where(:tld => query).select([:tld, :name]).limit(1).first
  end

  protected
    def transform_tld
      self.tld = tld.to_slug.normalize!(:to_ascii => true) unless tld.blank?
    end
end
