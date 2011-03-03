require Rails.root.join('lib', 'carrierwave', 'sanitized_file', 'compat')
require Rails.root.join('lib', 'carrierwave', 'uploader', 'compat')

$mongo = if Rails.env.production?
  require 'uri'
  uri = URI(ENV['MONGOHQ_URL'])
  db  = uri.path
  connection, _ = Mongo::Connection.from_uri uri
  connection.db(db)
else
  Mongo::Connection.new.db('gemsmine')
end

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
  config.s3_access_policy     = :private

  config.grid_fs_connection = $mongo
  config.grid_fs_access_url = '/'
  config.cache_dir = Rails.root.join('tmp', 'carrierwave')
end