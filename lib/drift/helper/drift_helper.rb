module DriftHelper

  def single_actor(activity, current_act, seq, async = false)
    SingleActor.new(activity, current_act, seq, async)
  end

  def condition_actor(then_activity, else_activity, condition, current_act, seq, async = false)
    ConditionActor.new(then_activity, else_activity, condition, current_act, seq, async)
  end

  def switch_actor(activities, condition, current_act, seq, async = false)
    SwitchActor.new(activities, condition, current_act, seq, async)
  end

end