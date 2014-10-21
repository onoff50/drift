require_relative 'base_actor'
require_relative '../metadata/switch_actor_metadata'

module Drift

  class SwitchActor < BaseActor

    @@condition_seq = 0
    @@self_id_seq = 1
    @@async_seq = 2
    @@queue_seq = 3

    #args:
    # condition code block
    # act class name
    # actor id (String)
    # async as boolean
    # queue name
    def initialize(*args)
      if args.length > 0
        create_metadata(args[@@condition_seq], args[@@self_id_seq], args[@@async_seq])
        @queue_name = args[@@queue_seq]
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
    def create_metadata(condition, id, async)
      @metadata = SwitchActorMetadata.new
      register_base_actor_metadata(id, async)
      @metadata.condition = condition
    end

  end

end
