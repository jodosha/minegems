class Version < ActiveRecord::Base
  belongs_to :rubygem
  mount_uploader :file, RubygemUploader
  validates_with GemValidator
  validates_presence_of :file, :number
  delegate :name, :gemspec, :version_number, :process!, :to => :file
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
      self.number = version_number
    end
end
