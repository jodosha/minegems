# encoding: utf-8
require 'fileutils'

class IndexUploader < CarrierWave::Uploader::Base
  storage :grid_fs
  attr_accessor :vault, :file_name

  def store_dir
    "indices/#{model.tld}"
  end

  def save!
    ensure_paths!
    store!(io(compress!))
  end

  private
    def compress!
      final = StringIO.new
      gzip = Zlib::GzipWriter.new(final)
      gzip.write(Marshal.dump(vault))
      gzip.close
      final.string
    end

    def ensure_paths!
      FileUtils.mkdir_p model_cache_dir
    end

    def model_cache_dir
      "#{cache_dir}/indices/#{model.id}"
    end

    def model_cache_spec
      model_cache_dir + '/' + file_name
    end

    def io(string)
      file = ::File.open(model_cache_index, 'w')
      file.write(string)
      CarrierWave::SanitizedFile.new(file)
    end
end
