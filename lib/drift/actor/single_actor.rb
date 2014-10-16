module Drift

  class SingleActor < BaseActor

    def initialize(single_activity, act, id, async)
      create_metadata(single_activity, act, id, async)
    end

    def do_action(context)
      single_activity.perform(context)
      single_activity
    end

    private
    def create_metadata(single_activity, act, id, async)
      @metadata = SingleActorMetadata.new
      register_base_actor_metadata(act, id, async)
      @metadata.single_activity = single_activity
    end

    private
    def single_activity
      @metadata.single_activity
    end

  end

end