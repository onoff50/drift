module Drift

  class ClientMiddleware

    def call(worker_class, msg, queue, redis_pool)
      queue = msg["args"][2]
      msg["queue"] = queue
      yield
    end

  end

end