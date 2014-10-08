module Drift

  class SingleActor < BaseActor


    attr_accessor :activity

    def initialize(activity)
      super()
      @activity = activity
    end

    def do_action_async(context)
      @activity.perform_async(context)
    end

    def do_action(context)
      @activity.perform(context)
    end

    def register_next(actor)
      next_actor_map[@activity] = actor
      actor
    end

    def next_actor
      next_actor_map[@activity]
    end

  end #end of class


end #end of module