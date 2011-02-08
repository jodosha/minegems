require Rails.root.join('lib', 'carrierwave', 'sanitized_file', 'compat')
require Rails.root.join('lib', 'carrierwave', 'uploader', 'compat')

# TODO configure according to the current environment
$mongo = Mongo::Connection.new.db('gemsmine')

s3_bucket = case Rails.env
when 'development', 'test'
  "gemsmine-#{Rails.env}"
else
  'gemsmine'
end

CarrierWave.configure do |config|
  config.s3_access_key_id     = "0WSTNF8GVS4A9AQAWWG2"
  config.s3_secret_access_key = "P0hnVy1Z8BMySyErifaCTxH4h84NRMjlHEmn8HGC"
  config.s3_bucket            = s3_bucket
  config.s3_access_policy     = :public_read

  config.grid_fs_connection = $mongo
  config.grid_fs_access_url = '/'
  config.cache_dir = Rails.root.join('tmp', 'carrierwave')
end