module Drift
  class BaseActor
    include Sidekiq::Worker

    attr_accessor :id, :act, :metadata

    #args:
    # act class name
    # async as boolean
    def initialize(act, id, async)
      @act = act
      @id = id
      create_metadata(async)
    end

    def execute context
      if async?
        perform_async context, @act, @id, @metadata
      else
        perform context
      end
    end

    def perform(context, act = nil, id = nil, metadata = nil)
      @act = act unless act.nil?
      @id = id unless id.nil?
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

    protected
    def do_action(context)
      raise DriftException, 'Not Implemented'
    end

    private
    def pre_action(context)
      #implement if required
    end

    def post_action(context, activity)
      next_actor = @metadata.next_actor activity
      @act.execute_next next_actor, context
    end

    def create_metadata(async)
      @metadata = ActorMetadata.new
      @metadata.async = async
    end

    def async?
      @metadata.async
    end

  end
end