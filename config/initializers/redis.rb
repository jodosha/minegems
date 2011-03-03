# $redis = if Rails.env.test?
#   require Rails.root.join('spec/support/mock_redis')
#   MockRedis.new
# else
#   Redis.new :thread_safe => true
# end
redis_options = { :thread_safe => true }

if Rails.env.production?
  uri = URI.parse(ENV["REDISTOGO_URL"])
  redis_options.merge!({ :host => uri.host, :port => uri.port, :password => uri.password })
end

$redis = Redis.new(redis_options)

# Minegems::Rack::SubdomainRouter.ensure_consistent_lookup!
# Minegems::Rack::SubdomainRouter.ensure_consistent_access!