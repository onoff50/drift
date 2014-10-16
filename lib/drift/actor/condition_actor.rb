module Drift

  class ConditionActor < BaseActor

    #args:
    # then_activity class
    # else_activity class
    # condition code block
    # act class
    # actor id (String)
    # async as boolean
    def initialize(then_activity, else_activity, condition, current_act, id, async)
      create_metadata(then_activity, else_activity, condition, current_act, id, async)
    end

    def do_action(context)
      condition_satisfied = condition.call(context)
      condition_satisfied ? execute_then_activity(context) : execute_else_activity(context)
    end

    private
    def execute_else_activity(context)
      else_activity.perform(context) if @else_activity
      else_activity
    end

    private
    def execute_then_activity(context)
      then_activity.perform(context)
      then_activity
    end

    private
    def create_metadata(then_activity, else_activity, condition, act, id, async)
      @metadata = ConditionalActorMetadata.new
      register_base_actor_metadata(act, id, async)
      @metadata.then_activity = then_activity
      @metadata.else_activity = else_activity
      @metadata.condition = condition
    end

    private
    def then_activity
      @metadata.then_activity
    end

    private
    def else_activity
      @metadata.else_activity
    end

    private
    def condition
      @metadata.condition
    end

  end

end