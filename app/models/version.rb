class Version < ActiveRecord::Base
  belongs_to :rubygem
  mount_uploader :file, RubygemUploader
  validates_with GemValidator
  validates_presence_of :file, :number, :platform
  delegate :name, :gemspec, :version_prerelease, :version_number, :version_platform, :process!, :to => :file
  before_validation :extract_data
  after_save        :reorder_versions

  scope :by_number,  order('number')
  scope :prerelease, where(:prerelease => true)
  scope :release,    where(:prerelease => false)
  scope :latest,     where(:latest     => true)

  def self.create_from_file(file, subdomain)
    version = new :file => file
    version.process!
    rubygem = Rubygem.find_or_create_by_name_and_subdomain_id(version.name, subdomain.id)
    rubygem.versions << version
    rubygem.save

    version
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

  private
    def extract_data
      self.number     = version_number
      self.prerelease = version_prerelease
      self.platform   = version_platform
      true
    end

    def reorder_versions
      rubygem.reorder_versions
    end
end
