module Drift
  class BaseActor
    include Sidekiq::Worker

    attr_accessor :metadata, :queue_name

    def initialize
      raise DriftException, 'BaseActor not supposed to be initialized'
    end

    def execute context
      if async?
        self.class.perform_async context, @metadata, @queue_name
      else
        perform context
      end
    end

    def perform(context, metadata = nil)
      @metadata = metadata unless metadata.nil?

      pre_action context
      block_val = do_action context
      post_action context, block_val
      context
    end

    #args:
    # actor object
    # block value
    def register_next(actor, value = nil)
      @metadata.register_next_actor actor, value
    end

    #args:
    # actor object
    def register_side_actors(*actors)
      actors.each do |actor|
        @metadata.register_side_actor actor
      end
    end

    def id
      @metadata.id
    end

    def act_name=(act_class_name)
      @metadata.act_name = act_class_name
    end

    protected
    def do_action(context)
      raise DriftException, 'Not Implemented'
    end

    protected
    def register_base_actor_metadata(id, async)
      @metadata.id = id
      @metadata.async = async
    end

    private
    def pre_action(context)
      #implement if required
    end

    def post_action(context, block_val)
      @metadata.side_actor_list.each do |side_actor|
        act_class.execute_next side_actor, context
      end

      next_actor = @metadata.next_actor block_val
      act_class.execute_next next_actor, context unless next_actor.nil?
    end

    def async?
      @metadata.async
    end

    def act_class
      Kernel.const_get(@metadata.act_name)
    end

  end
end