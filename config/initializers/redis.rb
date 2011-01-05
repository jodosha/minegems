$redis = if Rails.env.test?
  require Rails.root.join('spec/support/mock_redis')
  MockRedis.new
else
  Redis.new
end

Subdomain.ensure_consistent_lookup!