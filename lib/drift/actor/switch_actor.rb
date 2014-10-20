module Drift

  class SwitchActor < BaseActor

    #args:
    # activities hash ['key' => Activity Class]
    # condition code block
    # act class name
    # actor id (String)
    # async as boolean
    def initialize(*args)
      if args.length > 0
        validate_activity_list_arg args[0]
        create_metadata(args[0], args[1], args[2], args[3], args[4])
      end
    end

    def do_action(context)
      val = condition.call(context)
      activity = activities[val]

      if activity.nil?
        activity = activities[:default]
        raise DriftException, "No default activity found for switch val = #{val}" if activity.nil?
      end

      activity.perform(context)
      activity
    end

    private
    def create_metadata(activities, condition, act_name, id, async)
      @metadata = SwitchActorMetadata.new
      register_base_actor_metadata(act_name, id, async)
      @metadata.activities = activities
      @metadata.condition = condition
    end

    private
    def activities
      @metadata.activities
    end

    private
    def condition
      @metadata.condition
    end

    private
    def validate_activity_list_arg arg_list
      raise DriftException, 'args[0] should be an Activity Class Hash - [\'key\' => Activity_Class]' unless arg_list.is_a? Hash
      arg_list.each do |key, activity|
        raise DriftException, "args[0][#{key}] should be an Activity Class" unless activity.is_a? Class
      end
    end

  end

end
