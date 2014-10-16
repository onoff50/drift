module Drift
  class BaseActor
    include Sidekiq::Worker

    attr_accessor :metadata

    def initialize
      raise DriftException, 'BaseActor not supposed to be initialized'
    end

    def execute context
      if async?
        perform_async context, @metadata
      else
        perform context
      end
    end

    def perform(context, metadata = nil)
      @metadata = metadata unless metadata.nil?

      pre_action context
      activity = do_action context
      post_action context, activity
      context
    end

    #args:
    # actor object
    # activity class name
    def register_next_actor(actor, activity = 'default')
      @metadata.register_next_actor actor, activity
    end

    def id
      @metadata.id
    end

    protected
    def do_action(context)
      raise DriftException, 'Not Implemented'
    end

    protected
    def register_base_actor_metadata(act, id, async)
      @metadata.act = act
      @metadata.id = id
      @metadata.async = async
    end

    private
    def pre_action(context)
      #implement if required
    end

    def post_action(context, activity)
      next_actor = @metadata.next_actor activity
      act.execute_next next_actor, context unless next_actor.nil?
    end

    def async?
      @metadata.async
    end

    def act
      Kernel.const_get(@metadata.act)
    end

  end
end