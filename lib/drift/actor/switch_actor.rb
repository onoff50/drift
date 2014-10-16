module Drift

  class SwitchActor < BaseActor

    #args:
    # activities [class]
    # condition code block
    # act class name
    # actor id (String)
    # async as boolean
    def initialize(*args)
      create_metadata(args[0], args[1], args[2], args[3], args[4])
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

  end

end
