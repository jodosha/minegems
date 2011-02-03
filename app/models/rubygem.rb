class Rubygem < ActiveRecord::Base
  belongs_to :subdomain
  has_many :versions
  validates_presence_of :name, :subdomain_id
  validates_uniqueness_of :name

  scope :by_name, lambda { |name|
    where("name = ?", name)
  }

  def self.create_version(file, subdomain)
    Version.create_from_file(file, subdomain).rubygem || new
  end

  def version(number)
    versions.first(:conditions => [ "versions.number = ?", number ])
  end
end
