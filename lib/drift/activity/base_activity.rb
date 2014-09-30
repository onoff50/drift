module Drift

  class BaseActivity

    class << self

      def execute(args = {})
        $logger.info "Not Implemented"
        raise DriftException, "Not Implemented"
      end
    end

  end

end