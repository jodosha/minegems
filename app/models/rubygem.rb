class Rubygem < ActiveRecord::Base
  mount_uploader :file, RubygemUploader
  validates_presence_of :file
end
