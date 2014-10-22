module Drift

  class BaseActivity

    class << self

      undef_method :new

      def perform(context)
        pre_activity context
        do_execute context
        post_activity context
      end

      def pre_activity(context)
        $logger.info "Entering #{self.name} Activity."
        $logger.info "INPUT #{context.inspect}"
      end

      def post_activity(context)
        $logger.info "Exiting #{self.name} Activity."
        $logger.info "OUTPUT #{context.inspect}"
      end

      def do_execute(context)
        $logger.info "Not Implemented"
        raise DriftException, "Not Implemented"
      end

    end

  end

end