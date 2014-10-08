module Drift


  class SwitchActor < BaseActor

    #todo:write test cases
    #todo: write documentation README


    # sample activities = {1 => A1, 2 => A2}
    def initialize(activities = {}, condition = nil)
      super()
      @activities = activities
      @condition = condition
    end

    def do_action(context)
      val = @condition.call(context)

      $logger.info "Switch Val = #{val}"

      activity = @activities[val]


      #todo: add test  for below if condition
      if activity.blank?
        $logger.info "No activity found for val = #{val}, will use default case."
        activity = @activities[:default]
      end

      #todo: add test for below exception
      raise DriftException, "No default activity found for switch val = #{val}" if activity.blank?

      #setting current activity
      @current_activity = activity

      activity.perform(context) if activity.present?
    end

    def register_next_for_all(actor)
      @activities.values.each do |activity|
          register_next(activity, actor)
      end
    end

  end #end of class SwitchActor

end #end of module Drift
