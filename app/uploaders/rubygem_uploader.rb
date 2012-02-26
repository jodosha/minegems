# encoding: utf-8

class RubygemUploader < CarrierWave::Uploader::Base
  process :gemspec

  def store_dir
    'gems'
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

  def version_summary
    gemspec.try(:summary)
  end

  def version_description
    gemspec.try(:description)
  end

  def version_authors
    gemspec.try(:authors)
  end

  def gem_version
    gemspec.try(:version)
  end

  def extension_white_list
    %w(gem)
  end

  private
    def file_stream
      @file_stream ||= begin
        f = file.instance_variable_get(:@file)
        f.is_a?(String) ? ::File.open(f) : f
      end
    end
end
