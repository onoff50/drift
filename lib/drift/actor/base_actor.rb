module Drift
  class BaseActor
    include Sidekiq::Worker

    attr_accessor :next_actor_map, :current_activity


    def initialize
      @next_actor_map = {}
      @current_activity = nil
      @async = false
    end

    # this shouldn't be overridden by child classes
    def perform(context, next_actor_map = @next_actor_map, current_activity = @current_activity)
      action context
      post_action context, next_actor_map, current_activity
      context
    end

    # Every actor will call action() to perform activity.
    # Actors should NOT extend action().
    # Common action should be implemented in here, for example returning context after every activity.
    def action(context)
      $logger.info "#{self.class.name} takes action."
      do_action context
      context
    end

    def post_action(context, next_actor_map, current_activity)
      #next_actor.action context
      m = @async ? 'perform_async' : 'perform'
      nxt_actor = next_actor_map[current_activity]
      nxt_actor.send(m, context) if nxt_actor
    end

    # Actors should implement the do_action() to extent the functionality.
    def do_action(context)
      raise DriftException, 'Not Implemented'
    end

    #def to_s
    #  self.class.name
    #end

    def register_next(activity, actor, async = false)
      @next_actor_map[activity] = actor
      @async = async
      actor
    end

    def next_actor
      @next_actor_map[@current_activity]
    end

  end
end