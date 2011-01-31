# encoding: utf-8

class RubygemUploader < CarrierWave::Uploader::Base
  storage :file
  process :gemspec

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def gemspec
    @gemspec ||= begin
      if file.present?
        Gem::Format.from_io(file_stream).spec rescue nil
      end
    end
  end

  def name
    gemspec.try(:name)
  end

  def version_number
    gemspec.try(:version).try(:version)
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

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
