require_relative 'base_actor'
require_relative '../metadata/switch_actor_metadata'

module Drift

  class SwitchActor < BaseActor

    CONDITION_SEQ = 0
    SELF_ID_SEQ = 1
    ASYNC_SEQ = 2
    QUEUE_SEQ = 3

    #args:
    # condition code block
    # actor id (String)
    # async as boolean
    # queue name
    def initialize(*args)
      if args.length > 0
        create_metadata(args[CONDITION_SEQ], args[SELF_ID_SEQ], args[ASYNC_SEQ], args[QUEUE_SEQ])
      end
    end

    def do_action(context)
      condition.call(context)
    end

    def condition
      @metadata.condition
    end

    def condition=(sample_condition)
      @metadata.condition = sample_condition
    end

    private
    def create_metadata(condition, id, async, queue_name)
      @metadata = SwitchActorMetadata.new
      register_base_actor_metadata(id, async, queue_name)
      @metadata.condition = condition
    end

  end

end
