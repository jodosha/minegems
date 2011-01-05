class MockRedis
  @@data = {}

  def mapped_hmset(key, values)
    @@data[key] = values.stringify_keys
  end

  def mapped_hmget(key, *args)
    @@data[key]
  end

  def keys(pattern = "*")
    @@data.map do |k,v|
      k if pattern == "*" or k.match(pattern)
    end
  end

  def multi
    yield self
  end
end