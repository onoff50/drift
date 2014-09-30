module Drift
  class BaseActor

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
      raise DriftException, 'Not Implemented.'
    end

    def to_s
      self.class.name
    end
  end
end