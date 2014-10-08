  module DriftHelper

    def single_actor(activity)
      SingleActor.new(activity)
    end

    def condition_actor(then_activity, else_activity, condition)
      ConditionActor.new(then_activity, else_activity, condition)
    end


    def switch_actor(activities, condition)
      SwitchActor.new(activities, condition)
    end

  end