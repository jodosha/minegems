# encoding: utf-8

class RubygemUploader < CarrierWave::Uploader::Base
  storage :grid_fs
  process :gemspec

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def gemspec
    @gemspec ||= begin
      Gem::Format.from_io(file_stream).spec rescue nil
    end
  end

  def name
    gemspec.try(:name)
  end

  def version_number
    gem_version.try(:version)
  end

  def version_prerelease
    gem_version.try(:prerelease?) || false # force false when nil
  end

  def version_platform
    gemspec.try(:platform)
  end

  def gem_version
    gemspec.try(:version)
  end

  def extension_white_list
    %w(gem)
  end

  # Override the filename of the uploaded files:
  # def filename
  #   "something.jpg" if original_filename
  # end

  private
    def file_stream
      # FIXME this is a bit hackish, because by-passes Carrierwave public API
      @file_stream ||= begin
        f = file.instance_variable_get(:@file)
        f.is_a?(String) ? ::File.open(f) : f
      end
    end
end
