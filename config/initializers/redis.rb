# $redis = if Rails.env.test?
#   require Rails.root.join('spec/support/mock_redis')
#   MockRedis.new
# else
#   Redis.new :thread_safe => true
# end
$redis = Redis.connect :thread_safe => true, :url => ENV['REDISTOGO_URL']
Minegems::Rack::SubdomainRouter.ensure_consistent_lookup!
Minegems::Rack::SubdomainRouter.ensure_consistent_access!