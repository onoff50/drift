module Drift


  class SingleActor < BaseActor


    attr_accessor :activity

    def initialize(activity)
      @activity = activity
    end

    def act(args = {})
      @activity.execute(args)
    end



  end


end