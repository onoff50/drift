module Drift

  class BaseActivity

    class << self

      def execute(context)
        pre_activity context
        do_execute context
        post_activity context
      end

      def pre_activity(context)
        $logger.info "Entering #{self.name} Activity."
        $logger.info "INPUT #{context}"
      end

      def post_activity(context)
        $logger.info "Exiting #{self.name} Activity."
        $logger.info "OUTPUT #{context}"
      end

      # @param [BaseContext] context
      def do_execute(context)
        $logger.info "Not Implemented"
        raise DriftException, "Not Implemented"
      end

      def to_s
        self.name
      end
    end

  end

end