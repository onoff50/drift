module Drift

  class SingleActorMetadata < ActorMetadata

    attr_accessor :single_activity

    def initialize
      super
    end

    def to_json(*args)
      {
          'json_class'   => self.class.name,
          'data' => {
              'next_actor_map' => @next_actor_map,
              'async' => @async,
              'id' => @id,
              'single_activity' => @single_activity,
              'act' => @act
          }
      }.to_json(*args)
    end

    def self.json_create(json_data_hash)
      obj = new()
      obj.next_actor_map = json_data_hash['next_actor_map']
      obj.async = json_data_hash['async']
      obj.id = json_data_hash['id']
      obj.single_activity = json_data_hash['single_activity']
      obj.act = Kernel.const_get(json_data_hash['act'])
      obj
    end

  end

end

