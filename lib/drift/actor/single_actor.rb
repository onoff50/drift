module Drift

  class SingleActor < BaseActor


    def initialize(activity)
      super()
      @current_activity = activity
    end


    def do_action(context)
      @current_activity.perform(context)
    end

    def register_next(actor, async = false)
      super(@current_activity, actor, async)
    end


  end #end of class


end #end of module