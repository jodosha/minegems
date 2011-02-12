class Rubygem < ActiveRecord::Base
  belongs_to :subdomain
  has_many :versions, :dependent => :destroy
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

  def reorder_versions
    self.reload.versions.update_all(:latest => false)

    self.versions.release.inject(Hash.new { |h, k| h[k] = [] }) { |platforms, version|
      platforms[version.platform] << version
      platforms
    }.each_value do |platforms|
      Version.update_all({:latest => true}, {:id => platforms.sort.last.id})
    end
  end
end
