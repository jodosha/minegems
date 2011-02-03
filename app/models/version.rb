class Version < ActiveRecord::Base
  belongs_to :rubygem
  mount_uploader :file, RubygemUploader
  validates_with GemValidator
  validates_presence_of :file, :number, :platform
  delegate :name, :gemspec, :version_prerelease, :version_number, :version_platform, :process!, :to => :file
  before_validation :extract_data

  def self.create_from_file(file, subdomain)
    version = new :file => file
    version.process!
    rubygem = Rubygem.find_or_create_by_name_and_subdomain_id(version.name, subdomain.id)
    rubygem.versions << version
    rubygem.save

    version
  end

  private
    def extract_data
      self.number     = version_number
      self.prerelease = version_prerelease
      self.platform   = version_platform
      true
    end
end
