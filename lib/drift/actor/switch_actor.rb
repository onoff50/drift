module Drift

  class SwitchActor < BaseActor

    #args:
    # activities [class]
    # condition code block
    # act class
    # actor id (String)
    # async as boolean
    def initialize(activities, condition, act, id, async)
      create_metadata(activities, condition, act, id, async)
    end

    def do_action(context)
      val = condition.call(context)
      activity = activities[val]

      if activity.nil?
        if activities[:default].nil?
          raise DriftException, "No default activity found for switch val = #{val}"
        else
          activity = activities[:default]
        end
      end

      activity.perform(context)
      activity
    end

    private
    def create_metadata(activities, condition, act, id, async)
      @metadata = SwitchActorMetadata.new
      register_base_actor_metadata(act, id, async)
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
