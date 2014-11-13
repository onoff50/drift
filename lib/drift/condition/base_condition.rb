module Drift

  class BaseCondition

    class << self

      undef_method :new

      def eval_condition(context)
        $logger.error "Not Implemented"
        raise DriftException, "Not Implemented"
      end

    end

  end

end