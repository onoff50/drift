require_relative 'actor_metadata'

module Drift

  class SingleActorMetadata < ActorMetadata

    attr_accessor :activity

    def to_json(*args)
      {
          'json_class'   => self.class.name,
          'data' => {
              'next_actor_map' => @next_actor_map,
              'side_actor_list' => @side_actor_list,
              'rollback_actor' => @rollback_actor,
              'async' => @async,
              'id' => @id,
              'activity' => @activity,
              'act_name' => @act_name,
              'queue_name' => @queue_name
          }
      }.to_json(*args)
    end

    def self.json_create(json_data_hash)
      obj = new
      obj.next_actor_map = json_data_hash['next_actor_map']
      obj.side_actor_list = json_data_hash['side_actor_list']
      obj.rollback_actor = json_data_hash['rollback_actor']
      obj.async = json_data_hash['async']
      obj.id = json_data_hash['id']
      obj.activity = json_data_hash['activity']
      obj.act_name = json_data_hash['act_name']
      obj.queue_name = json_data_hash['queue_name']
      obj
    end

  end

end

