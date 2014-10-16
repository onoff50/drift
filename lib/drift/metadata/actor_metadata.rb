module Drift

  class ActorMetadata

    attr_accessor :next_actor_map, :async, :id, :act

    def initialize
      @next_actor_map = {}
      @async = false
    end

    #args:
    # actor object
    # activity class name
    def register_next_actor(actor, activity = 'default')
      raise DriftException, 'no next actor registration for null activity' if activity.nil?
      @next_actor_map[activity.to_sym] = actor.id
    end

    #args:
    # activity class name
    def next_actor(activity = 'default')
      raise DriftException, 'no next actor for null activity' if activity.nil?
      @next_actor_map[activity.to_sym] || @next_actor_map[:default]
    end

    def marshal_dump
      [@next_actor_map, @async, @id, @act.name]
    end

    def marshal_load attr_array
      @next_actor_map, @async, @id, @act = attr_array
    end

  end
end
