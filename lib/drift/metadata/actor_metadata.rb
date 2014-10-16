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
      @next_actor_map[activity.nil? ? nil : activity.name.to_sym] || @next_actor_map[:default]
    end

    def to_json(*args)
      {
          'json_class'   => self.class.name,
          'data' => {
              'next_actor_map' => @next_actor_map,
              'async' => @async,
              'id' => @id,
              'act' => @act
          }
      }.to_json(*args)
    end

    def self.json_create(json_data_hash)
      obj = new()
      obj.next_actor_map = json_data_hash['next_actor_map']
      obj.async = json_data_hash['async']
      obj.id = json_data_hash['id']
      obj.act = Kernel.const_get(json_data_hash['act'])
      obj
    end

  end
end
