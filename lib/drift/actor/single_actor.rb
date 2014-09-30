module Drift


  class SingleActor < BaseActor


    attr_accessor :activity

    def initialize(activity)
      @activity = activity
    end

    def do_action(context)
      @activity.execute(context)
    end


  end #end of class


end #end of module