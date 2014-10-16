module Drift

  class SingleActorMetadata < ActorMetadata

    attr_accessor :single_activity

    def initialize
      super
    end

    def marshal_dump
      [@next_actor_map, @async, @id, @act.name, @single_activity]
    end

    def marshal_load attr_array
      @next_actor_map, @async, @id, @act, @single_activity = attr_array
    end

  end

end

