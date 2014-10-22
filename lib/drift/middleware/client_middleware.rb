module Drift

  class ClientMiddleware

    def call(worker_class, msg, queue, redis_pool)
      queue_name = msg["args"][2]
      unless queue_name.nil?
        queue = queue_name
        msg["queue"] = queue_name
      end
      yield
    end

  end

end