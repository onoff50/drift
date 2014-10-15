module Drift

  class ServerMiddleware

    def call(worker, msg, queue)
      yield
    end

  end

end
