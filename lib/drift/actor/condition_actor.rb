module Drift


  class ConditionActor < BaseActor

    attr_accessor :then_activity, :else_activity, :condition

    def initialize(then_activity, else_activity, &condition)
      @then_activity = then_activity
      @else_activity = else_activity
      @condition = condition
    end


    def act(args = {})

      if @condition.call(args)
        @then_activity.execute(args)
      else
        @else_activity.execute(args)
      end

    end


  end

end