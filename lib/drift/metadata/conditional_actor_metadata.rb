module Drift

  class ConditionalActorMetadata < ActorMetadata

    attr_accessor :then_activity, :else_activity, :condition

    def initialize
      super
    end

    def marshal_dump
      [@next_actor_map, @async, @id, @act.name, @then_activity, @else_activity, @condition.to_source]
    end

    def marshal_load attr_array
      @next_actor_map, @async, @id, @act, @then_activity, @else_activity, @condition = attr_array
      @condition = eval(@condition)
    end

  end

end
