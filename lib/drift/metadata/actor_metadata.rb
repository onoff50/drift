module Drift

  class ActorMetadata

    #
    # side actors should be of async type (fire and forget)
    # they will get fired only after successful do_action
    attr_accessor :next_actor_map, :async, :id, :act_name, :side_actor_list, :queue_name

    def initialize
      @next_actor_map = {}
      @async = false
      @side_actor_list = []
      @queue_name = 'default'
    end

    #args:
    # actor object
    # block value
    def register_next_actor(actor, value = nil)
      @next_actor_map[value] = actor.id
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

    def to_json(*args)
      {
          'json_class'   => self.class.name,
          'data' => {
              'next_actor_map' => @next_actor_map,
              'async' => @async,
              'id' => @id,
              'act_name' => @act_name,
              'queue_name' => @queue_name
          }
      }.to_json(*args)
    end

    def self.json_create(json_data_hash)
      obj = new()
      obj.next_actor_map = json_data_hash['next_actor_map']
      obj.async = json_data_hash['async']
      obj.id = json_data_hash['id']
      obj.act_name = json_data_hash['act_name']
      obj.queue_name = json_data_hash['queue_name']
      obj
    end

  end
end
