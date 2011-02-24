# encoding: utf-8
class Version < ActiveRecord::Base
  belongs_to :rubygem
  mount_uploader :file, RubygemUploader
  mount_uploader :spec, SpecUploader
  validates_with GemValidator
  validates_presence_of :file, :number, :platform
  delegate :name, :gemspec, :version_prerelease, :version_number,
    :version_platform, :version_summary, :version_description, :process!, :to => :file
  before_validation :extract_data
  after_save        :reorder_versions, :full_nameify!, :store_spec!

  scope :by_number,      order('number')
  scope :prerelease,     where(:prerelease => true)
  scope :release,        where(:prerelease => false)
  scope :latest,         where(:latest     => true)
  scope :by_full_name, lambda { |full_name|
    where("full_name = ?", full_name)
  }

  def self.create_from_file(file, subdomain)
    version = new :file => file
    version.process!
    rubygem = Rubygem.find_or_create_by_name_and_subdomain_id(version.name, subdomain.id)
    rubygem.versions << version
    rubygem.save

    version
  end

  def self.rubygem_name_for(full_name)
    $redis.hget(info_key(full_name), :name)
  end

  def self.info_key(full_name)
    "v:#{full_name}"
  end

  def <=>(other)
    self_version  = self.to_gem_version
    other_version = other.to_gem_version

    if self_version == other_version
      self.platform_as_number <=> other.platform_as_number
    else
      self_version <=> other_version
    end
  end

  def platform_as_number
    case self.platform
      when 'ruby' then 1
      else             0
    end
  end

  def to_gem_version
    Gem::Version.new(number)
  end

  def to_index
    [ rubygem.name, to_gem_version, platform ]
  end

  def platformed?
    platform != "ruby"
  end

  private
    def extract_data
      self.number      = version_number
      self.prerelease  = version_prerelease
      self.platform    = version_platform
      self.summary     = version_summary
      self.description = version_description
      true
    end

    def reorder_versions
      rubygem.reorder_versions
    end

    def store_spec!
      self.spec.save!
    end

    def full_nameify!
      self.full_name = "#{rubygem.name}-#{number}"
      self.full_name << "-#{platform}" if platformed?

      Version.update_all({:full_name => full_name}, {:id => id})

      $redis.hmset(Version.info_key(full_name),
                   :name, rubygem.name,
                   :number, number,
                   :platform, platform)

      true
    end
end
