module Drift

  class SwitchActor < BaseActor

    attr_accessor :activities, :condition

    def initialize(activities, condition, current_act, seq, async)
      super(current_act, seq, async)
      @activities = activities
      @condition = condition
    end

    def do_action(context)
      val = @condition.call(context)
      activity = @activities[val]

      if activity.nil?
        if @activities[:default].nil?
          raise DriftException, "No default activity found for switch val = #{val}"
        else
          activity = @activities[:default]
        end
      end

      activity.perform(context)
      activity
    end

  end

end
