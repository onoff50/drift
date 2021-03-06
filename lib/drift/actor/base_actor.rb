require_relative '../../../lib/drift/worker'

module Drift
  class BaseActor
    include Drift::Worker

    attr_accessor :metadata

    def initialize
      raise DriftException, 'BaseActor not supposed to be initialized'
    end

    def identity
      raise DriftException, 'BaseActor can not be identified'
    end

    def execute(context)
      if async?
        self.class.perform_async context, @metadata.act_name, @metadata.id, @metadata.queue_name
      else
        perform context
      end
    end

    def perform(context, metadata = nil)
      @metadata = metadata unless metadata.nil?

      pre_action context
      begin
        block_val = do_action context
      rescue DriftException
        perform_rollback context
      else
        post_action context, block_val
      end

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

    #args:
    # actor object
    def register_rollback(actor)
      @metadata.register_rollback_actor actor
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
    def register_base_actor_metadata(id, async, queue_name)
      @metadata.id = id
      @metadata.async = async
      @metadata.queue_name = queue_name
    end

    private
    def pre_action(context)
      #implement if required
    end

    def post_action(context, block_val)
      @metadata.side_actor_list.each do |side_actor|
        act_class.execute_actor side_actor, context
      end

      next_actor = @metadata.next_actor block_val
      act_class.execute_actor next_actor, context unless next_actor.nil?
    end

    def perform_rollback(context)
      act_class.execute_actor @metadata.rollback_actor, context unless @metadata.rollback_actor.nil?
      raise DriftException, "actor #{self.class.name} failed with context #{context.inspect}"
    end

    def async?
      @metadata.async
    end

    def queue_name
      @metadata.queue_name
    end

    def act_class
      Kernel.const_get(@metadata.act_name)
    end

  end
end