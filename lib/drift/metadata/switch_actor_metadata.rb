require_relative 'actor_metadata'

module Drift

  class SwitchActorMetadata < ActorMetadata

    attr_accessor :condition

    def to_json(*args)
      {
          'json_class'   => self.class.name,
          'data' => {
              'next_actor_map' => @next_actor_map,
              'async' => @async,
              'id' => @id,
              'act_name' => @act_name,
              'condition' => @condition.to_source,
              'queue_name' => @queue_name
          }
      }.to_json(*args)
    end

    def self.json_create(json_data_hash)
      obj = new
      obj.next_actor_map = json_data_hash['next_actor_map']
      obj.async = json_data_hash['async']
      obj.id = json_data_hash['id']
      obj.condition = eval(json_data_hash['condition'])
      obj.act_name = json_data_hash['act_name']
      obj.queue_name = json_data_hash['queue_name']
      obj
    end

  end

end

