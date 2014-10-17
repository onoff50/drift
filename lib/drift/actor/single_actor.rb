module Drift

  class SingleActor < BaseActor

    #args:
    # single_activity class
    # act class name
    # actor id (String)
    # async as boolean
    def initialize(*args)
      if args.length > 0
        raise DriftException, 'args[0] should be an Activity Class' unless args[0].is_a? Class
        create_metadata(args[0], args[1], args[2], args[3])
      end
    end

    def do_action(context)
      single_activity.perform(context)
      single_activity
    end

    private
    def create_metadata(single_activity, act_name, id, async)
      @metadata = SingleActorMetadata.new
      register_base_actor_metadata(act_name, id, async)
      @metadata.single_activity = single_activity
    end

    private
    def single_activity
      @metadata.single_activity
    end

  end

end