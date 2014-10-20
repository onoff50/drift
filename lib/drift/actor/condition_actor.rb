module Drift

  class ConditionActor < BaseActor

    #args:
    # then_activity class
    # else_activity class
    # condition code block
    # act class name
    # actor id (String)
    # async as boolean
    def initialize(*args)
      if args.length > 0
        raise DriftException, 'args[0] should be an Activity Class' unless args[0].is_a? Class
        raise DriftException, 'args[1] should be an Activity/Nil Class' unless (args[1].is_a? Class) || (args[1].is_a? NilClass)
        create_metadata(args[0], args[1], args[2], args[3], args[4], args[5])
      end
    end

    def do_action(context)
      condition_satisfied = condition.call(context)
      $logger.info "CONTEXTz : #{context}"
      condition_satisfied ? execute_then_activity(context) : execute_else_activity(context)
    end

    private
    def execute_else_activity(context)
      else_activity.perform(context) if else_activity
      else_activity
    end

    private
    def execute_then_activity(context)
      then_activity.perform(context)
      then_activity
    end

    private
    def create_metadata(then_activity, else_activity, condition, act_name, id, async)

      @metadata = ConditionalActorMetadata.new
      register_base_actor_metadata(act_name, id, async)
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