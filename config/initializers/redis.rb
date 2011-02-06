# $redis = if Rails.env.test?
#   require Rails.root.join('spec/support/mock_redis')
#   MockRedis.new
# else
#   Redis.new :thread_safe => true
# end
$redis = Redis.new :thread_safe => true
Gemsmine::Rack::SubdomainRouter.ensure_consistent_lookup!
Gemsmine::Rack::SubdomainRouter.ensure_consistent_access!