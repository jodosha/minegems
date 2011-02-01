require 'set'

class MockRedis
  @@data = {}

  def mapped_hmset(key, values)
    @@data[key] = values.stringify_keys
  end

  def mapped_hmget(key, *args)
    @@data[key]
  end

  def sadd(key, value)
    @@data[key] ||= Set.new
    @@data[key] << value
  end

  def keys(pattern = "*")
    @@data.map do |k,v|
      k if pattern == "*" or k.match(pattern)
    end
  end

  def multi
    yield self
  end

  def sismember(set, key)
    @@data[set].include?(key)
  end
end