class Rubygem < ActiveRecord::Base
  mount_uploader :file, RubygemUploader
end
