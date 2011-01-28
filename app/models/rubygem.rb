class Rubygem < ActiveRecord::Base
  mount_uploader :file, RubygemUploader
  has_many :versions
  validates_presence_of :file, :name
  validates_with GemValidator
  before_validation :create_data_from_gemspec

  scope :by_name, lambda { |name|
    where("name = ?", name)
  }

  def self.create_from_file(file)
    rg = new :file => file
    rubygem = by_name(rg.name)
    rubygem = rubygem.any? ? rubygem.first : rg
    rubygem.file = file
    rubygem.save
  end

  def version(number)
    versions.first(:conditions => [ "versions.number = ?", number ])
  end

  def spec
    @spec ||= begin
      if file.present?
        Gem::Format.from_io(file_stream).spec rescue nil
      end
    end
  end

  def name
    @name ||= read_attribute(:name) || spec.try(:name)
  end

  private
    def create_data_from_gemspec
      self.name = name
      self.versions.build(:number => spec.try(:version).try(:version))
    end

    def file_stream
      # FIXME this is a bit hackish, because by-passes Carrierwave public API
      @file_stream ||= begin
        f = file.file.instance_variable_get(:@file)
        f.is_a?(String) ? ::File.open(f) : f
      end
    end
end
