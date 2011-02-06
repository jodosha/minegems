require Rails.root.join('lib', 'carrierwave', 'sanitized_file', 'compat')
require Rails.root.join('lib', 'carrierwave', 'uploader', 'compat')

CarrierWave.configure do |config|
  # TODO configure according to the current environment
  config.grid_fs_database   = 'gemsmine'
  config.grid_fs_host       = 'localhost'
  config.grid_fs_access_url = '/'
  config.cache_dir = Rails.root.join('tmp', 'carrierwave')
end