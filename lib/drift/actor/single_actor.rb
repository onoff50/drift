require_relative 'base_actor'
require_relative '../metadata/single_actor_metadata'

module Drift

  class SingleActor < BaseActor

    ACTIVITY_SEQ = 0
    SELF_ID_SEQ = 1
    ASYNC_SEQ = 2
    QUEUE_SEQ = 3

    #args:
    # single_activity class
    # actor id (String)
    # async as boolean
    # queue name
    def initialize(*args)
      if args.length > 0
        create_metadata(args[ACTIVITY_SEQ], args[SELF_ID_SEQ], args[ASYNC_SEQ], args[QUEUE_SEQ])
      end
    end

    def do_action(context)
      activity.perform(context)
      nil
    end

    def identity
      @metadata.activity.name
    end

    private
    def create_metadata(activity, id, async, queue_name)
      @metadata = SingleActorMetadata.new
      register_base_actor_metadata(id, async, queue_name)
      @metadata.activity = activity
    end

    private
    def activity
      @metadata.activity
    end

  end

end