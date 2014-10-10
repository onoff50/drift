module Drift

  class SingleActor < BaseActor

    def initialize(activity, next_actor_map = {}, async = false)
      super(next_actor_map, async)
      @current_activity = activity
    end

    def do_action(context)
      @current_activity.perform(context)
    end

    def register_next(actor, async = false)
      super(@current_activity, actor, async)
    end

    def self.json_create(json_data_hash)
      new(Kernel.const_get(json_data_hash['current_activity']), load_next_actor(json_data_hash), json_data_hash['async'])
    end

  end

end