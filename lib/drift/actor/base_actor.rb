module Drift
  class BaseActor

    attr_accessor :next_actor_map, :current_activity

    def initialize
       @next_actor_map = {}
       @current_activity = nil
    end
    # Every actor will call action() to perform activity.
    # Actors should NOT extend action().
    # Common action should be implemented in here, for example returning context after every activity.
    def action(context)
      $logger.info "#{self.class.name} takes action."
      do_action context
      context
    end

    # Actors should implement the do_action() to extent the functionality.
    def do_action(context)
      raise DriftException, 'Not Implemented'
    end

    #def to_s
    #  self.class.name
    #end

    def register_next(activity, actor)
      @next_actor_map[activity] = actor
      actor
    end

    def next_actor
      @next_actor_map[@current_activity]
    end

  end
end