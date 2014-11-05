module Drift

  class ActorMetadata

    #
    # side actors should be of async type (fire and forget)
    # they will get fired only after successful do_action
    attr_accessor :next_actor_map, :async, :id, :act_name, :side_actor_list, :queue_name, :rollback_actor

    def initialize
      @next_actor_map = {}
      @async = false
      @side_actor_list = []
      @queue_name = nil
      @rollback_actor = nil
    end

    #args:
    # actor object
    # block value
    def register_next_actor(actor, value = nil)
      @next_actor_map[value] = actor.id
    end

    #args:
    # actor object
    def register_rollback_actor(actor)
      @rollback_actor = actor.id
    end

    #args:
    # actor object
    def register_side_actor(actor)
      @side_actor_list << actor.id
    end

    #args:
    # block value
    def next_actor(value = nil)
      @next_actor_map[value] || @next_actor_map[nil]
    end

  end
end
