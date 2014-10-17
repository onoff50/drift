module Drift

  class ClientMiddleware

    def call(worker_class, msg, queue, redis_pool)
      yield
    end

  end

end