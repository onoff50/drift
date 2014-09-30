module Drift



  class SwitchActor < BaseActor

    #todo:write test cases
    #todo: write documentation README


    # sample activities = {1 => A1, 2 => A2}
    def initialize(activities = {}, &condition)
      @activities = activities
      @condition = condition
    end

    def action(args = {})
      val = @condition.call(args)
      $logger.info "Switch Val = #{val}"

      activity = @activities[val]

      if activity.blank?
        $logger.info "No activity found for val = #{val}, will use default case."
        activity = @activities[:default]
      end

      raise "No default activity found for switch val = #{val}" unless activity.present?

      activity.execute(args)
    end

  end

end