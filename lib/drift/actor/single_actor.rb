require_relative 'base_actor'
require_relative '../metadata/single_actor_metadata'

module Drift

  class SingleActor < BaseActor

    @@activity_seq = 0
    @@self_id_seq = 1
    @@async_seq = 2
    @@queue_seq = 3

    #args:
    # single_activity class
    # actor id (String)
    # async as boolean
    # queue name
    def initialize(*args)
      if args.length > 0
        create_metadata(args[@@activity_seq], args[@@self_id_seq], args[@@async_seq])
        @queue_name = args[@@queue_seq]
      end
    end

    def do_action(context)
      activity.perform(context)
      nil
    end

    private
    def create_metadata(activity, id, async)
      @metadata = SingleActorMetadata.new
      register_base_actor_metadata(id, async)
      @metadata.activity = activity
    end

    private
    def activity
      @metadata.activity
    end

  end

end