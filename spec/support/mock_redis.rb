class MockRedis
  @@data = {}

  def mapped_hmset(key, values)
    @@data[key] = values.stringify_keys
  end

  def mapped_hmget(key, *args)
    @@data[key]
  end
end