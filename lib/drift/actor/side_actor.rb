module Drift
  class SideActor < SingleActor

    def do_action(context)
      @activity.perform_async(context)
    end

  end
end