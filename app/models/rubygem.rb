class Rubygem < ActiveRecord::Base
  belongs_to :subdomain
  has_many :versions
  validates_presence_of :name, :subdomain_id
  # before_validation :create_data_from_gemspec

  scope :by_name, lambda { |name|
    where("name = ?", name)
  }

  def self.create_version(file, subdomain)
    Version.create_from_file(file, subdomain).rubygem || new
  end

  def version(number)
    versions.first(:conditions => [ "versions.number = ?", number ])
  end

  private
    def create_data_from_gemspec
      self.name = name
      self.versions.build(:number => spec.try(:version).try(:version))
    end
end
