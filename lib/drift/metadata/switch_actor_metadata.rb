module Drift

  class SwitchActorMetadata < ActorMetadata

    attr_accessor :activities, :condition

    def initialize
      super
    end

    def marshal_dump
      [@next_actor_map, @async, @id, @act.name, @activities, @condition.to_source]
    end

    def marshal_load attr_array
      @next_actor_map, @async, @id, @act, @activities, @condition = attr_array
      @condition = eval(@condition)
    end

  end

end

