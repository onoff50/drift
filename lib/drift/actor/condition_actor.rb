module Drift

  class ConditionActor < BaseActor

    attr_accessor :then_activity, :else_activity, :condition

    def initialize(then_activity, else_activity, condition, current_act, id, async)
      super(current_act, id, async)
      @then_activity = then_activity
      @else_activity = else_activity
      @condition = condition
    end

    def do_action(context)
      condition_satisfied = @condition.call(context)
      condition_satisfied ? execute_then_activity(context) : execute_else_activity(context)
    end


    ############ Private Method   #################

    private
    def execute_else_activity(context)
      @else_activity.perform(context) if @else_activity
      @else_activity
    end

    private
    def execute_then_activity(context)
      @then_activity.perform(context)
      @then_activity
    end

  end

end