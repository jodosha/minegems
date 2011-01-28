class Rubygem < ActiveRecord::Base
  mount_uploader :file, RubygemUploader
  validates_presence_of :file
  validates :file, :gem => true

  def spec
    @spec ||= begin
      if file.present?
        Gem::Format.from_io(file_stream).spec rescue nil
      end
    end
  end

  private
    def file_stream
      # FIXME this is a bit hackish, because by-passes Carrierwave public API
      @file_stream ||= begin
        f = file.file.instance_variable_get(:@file)
        f.is_a?(String) ? ::File.open(f) : f
      end
    end
end
