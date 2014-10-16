module Drift

  class ActMetadata

    #map of actor id vs actor instance
    attr_accessor :actors

    def initialize
      @actors = {}
    end

    #args
    # actor instance
    def register_actor(actor)
      @actors[actor.id] = actor
    end

    #args
    # actor id
    def actor(id)
      @actors[id]
    end

  end

end