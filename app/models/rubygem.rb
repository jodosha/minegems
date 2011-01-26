class Rubygem < ActiveRecord::Base
  mount_uploader :file, RubygemUploader
  validates_presence_of :file
  validate :spec_attributes

  def spec
    @spec ||= begin
      Gem::Format.from_io(file_stream).try(:spec) if file.present?
    end
  end

  private
    def file_stream
      file.file
    end

    def spec_attributes
      spec.present?
    end
end
