class Subdomain < ActiveRecord::Base
  attr_accessible :tld, :name

  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships

  validates_uniqueness_of :tld, :case_sensitive => false
  validates_length_of     :tld, :name, :maximum => 64
  validates_presence_of   :tld, :name

  validates :tld, :ascii => true

  before_validation :transform_tld
  after_save :update_lookup

  cattr_accessor :lookup_prefix
  self.lookup_prefix = "subdomains"

  def self.search(query)
    where(:tld => query).select([:tld, :name]).limit(1).first
  end

  def self.lookup(tld)
    $redis.mapped_hmget("#{lookup_prefix}.#{tld}", "tld", "name") rescue nil
  end

  def self.ensure_consistent_lookup!
    unless $redis.keys("#{lookup_prefix}.*").size == count
      $redis.multi do |redis|
        all(:select => [:tld, :name]).each do |subdomain|
          subdomain.send(:update_lookup, redis)
        end
      end
    end
  end

  protected
    def transform_tld
      self.tld = tld.to_slug.normalize!(:to_ascii => true) unless tld.blank?
    end

    def update_lookup(redis = $redis)
      redis.mapped_hmset("#{self.class.lookup_prefix}.#{tld}", :tld => tld, :name => name)
    end
end
