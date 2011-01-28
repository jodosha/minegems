class Rubygem < ActiveRecord::Base
  mount_uploader :file, RubygemUploader
  has_many :versions
  validates_presence_of :file, :name
  validates_with GemValidator
  before_validation :create_data_from_gemspec

  def version(number)
    versions.first(:conditions => { :number => number })
  end

  def spec
    @spec ||= begin
      if file.present?
        Gem::Format.from_io(file_stream).spec rescue nil
      end
    end
  end

  private
    def create_data_from_gemspec
      self.name = spec.try(:name)
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
