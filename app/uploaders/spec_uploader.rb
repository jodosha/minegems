# encoding: utf-8
require 'rubygems/indexer'

class SpecUploader < CarrierWave::Uploader::Base
  storage :grid_fs

  def store_dir
    "/quick/Marshal.4.8/#{model.rubygem.subdomain.tld}"
  end

  def save!
    ensure_paths!
    store!(io(gemspec))
  end

  protected
    def indexer
      @indexer ||= begin
        indexer = Gem::Indexer.new(cache_dir, :build_legacy => false)
        def indexer.say(message) end
        indexer
      end
    end

    def gemspec
      @gemspec ||= begin
        gemspec = model.file.gemspec
        indexer.abbreviate gemspec
        indexer.sanitize   gemspec
        gemspec
      end
    end

    def ensure_paths!
      FileUtils.mkdir_p model_cache_dir
    end

    def model_cache_dir
      "#{cache_dir}/specs/#{model.id}"
    end

    def model_cache_spec
      "#{model_cache_dir}/#{gemspec.original_name}.gemspec.rz"
    end

    def io(string)
      file = ::File.open(model_cache_spec, 'wb')
      file.write(Gem.deflate(Marshal.dump(string)))
      CarrierWave::SanitizedFile.new(file)
    end
end
