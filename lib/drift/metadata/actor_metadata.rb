module Drift

  class ActorMetadata

    attr_accessor :next_actor_map, :async, :id, :act_name, :rollback_actor

    def initialize
      @next_actor_map = {}
      @rollback_actor = nil
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
              'rollback_actor' => @rollback_actor,
              'async' => @async,
              'id' => @id,
              'act_name' => @act_name
          }
      }.to_json(*args)
    end

    def self.json_create(json_data_hash)
      obj = new()
      obj.next_actor_map = json_data_hash['next_actor_map']
      obj.rollback_actor = json_data_hash['rollback_actor']
      obj.async = json_data_hash['async']
      obj.id = json_data_hash['id']
      obj.act_name = json_data_hash['act_name']
      obj
    end

  end
end
