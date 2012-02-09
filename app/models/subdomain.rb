class Subdomain < ActiveRecord::Base

  attr_accessible :tld, :name

  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_one  :deploy_user, :through => :memberships, :conditions => ["role = 'deploy'"], :source => :user
  has_many :rubygems, :dependent => :destroy
  has_many :versions, :through => :rubygems

  validates_uniqueness_of :tld, :case_sensitive => false
  validates_length_of     :tld, :name, :maximum => 64
  validates_presence_of   :tld, :name
  validates :tld, :ascii => true

  before_validation :transform_tld
  after_create      :assign_deploy_user

  mount_uploader :specs_index,            IndexUploader
  mount_uploader :latest_specs_index,     IndexUploader
  mount_uploader :prerelease_specs_index, IndexUploader

  scope :by_tld, lambda { |tld|
    where("tld = ?", tld)
  }

  def self.search(query)
    where(:tld => query).select([:tld, :name]).limit(1).first
  end

  def update_index!
    update_specs_index!
    update_latest_specs_index!
    update_prerelease_specs_index!
  end

  protected
    def transform_tld
      self.tld = tld.to_slug.normalize!(:to_ascii => true) unless tld.blank?
    end

    def update_specs_index!
      self.specs_index.vault     = versions.map(&:to_index)
      self.specs_index.file_name = 'specs.4.8.gz'

      self.specs_index.save!
    end

    def update_latest_specs_index!
      self.latest_specs_index.vault     = versions.latest.map(&:to_index)
      self.latest_specs_index.file_name = 'latest_specs.4.8.gz'

      self.latest_specs_index.save!
    end

    def update_prerelease_specs_index!
      self.prerelease_specs_index.vault     = versions.prerelease.map(&:to_index)
      self.prerelease_specs_index.file_name = 'prerelease_specs.4.8.gz'

      self.prerelease_specs_index.save!
    end

  private
    def assign_deploy_user
      password = ActiveSupport::SecureRandom.hex(8)
      user = User.create!({
        :name                  => "#{self.name} deploy",
        :email                 => "#{self.tld}@minege.ms",
        :username              => "#{self.tld}-deploy",
        :password              => password,
        :password_confirmation => password,
        :deploy                => true
      })
      user.confirm!

      Membership.create!(:subdomain => self, :user => user, :role => 'deploy')
    end
end
