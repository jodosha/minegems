require Rails.root.join('lib', 'carrierwave', 'sanitized_file', 'compat')
require Rails.root.join('lib', 'carrierwave', 'uploader', 'compat')

# TODO configure according to the current environment
$mongo = Mongo::Connection.new.db('gemsmine')

CarrierWave.configure do |config|
  config.grid_fs_connection = $mongo
  config.grid_fs_access_url = '/'
  config.cache_dir = Rails.root.join('tmp', 'carrierwave')
end