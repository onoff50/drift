module Drift

  class SwitchActivity < BaseActivity

    #todo:write test cases
    #todo: write documentation README


    def initialize(activities = {}, &condition)
      @activities = activities
      @condition = condition
    end

    #todo: better logging
    def act(args = {})
      val = @condition.call(args)
      activity = @activities[val].present? ? @activities[val] : @activities[:default]

      raise "No activity found for swith val = #{val}" unless activity.present?

      activity.execute(args)
    end

  end

end