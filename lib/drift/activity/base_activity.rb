module Drift

  class BaseActivity

    class << self

      undef_method :new

      def perform(context)
        begin
          pre_activity context
          do_execute context
          post_activity context
        rescue Exception
          raise DriftException
        end
      end

      def pre_activity(context)
        $logger.debug "Entering #{self.name} Activity."
        $logger.debug "INPUT #{context.inspect}"
      end

      def post_activity(context)
        $logger.debug "Exiting #{self.name} Activity."
        $logger.debug "OUTPUT #{context.inspect}"
      end

      def do_execute(context)
        $logger.error "Not Implemented"
        raise DriftException, "Not Implemented"
      end

    end

  end

end