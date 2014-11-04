module Drift

  class BaseCondition

    class << self

      undef_method :new

      def eval_condition(context)
        raise DriftException, "Not Implemented"
      end

    end

  end

end