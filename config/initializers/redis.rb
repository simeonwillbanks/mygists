uri = URI.parse(ENV["REDIS_WORKER"])
REDIS_WORKER = Redis.new(host: uri.host, port: uri.port, password: uri.password)
