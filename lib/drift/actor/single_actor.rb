module Drift


  class SingleActor < BaseActor


    attr_accessor :activity

    def initialize(activity)
      @activity = activity
    end

    def act(args = {})
      $logger.info "Executing #{@activity.class} activity."
      @activity.execute(args)
    end


  end  #end of class


end  #end of module