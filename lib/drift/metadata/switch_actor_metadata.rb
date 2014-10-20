module Drift

  class SwitchActorMetadata < ActorMetadata

    attr_accessor :activities, :condition

    def initialize
      super
    end

    def to_json(*args)
      {
          'json_class'   => self.class.name,
          'data' => {
              'next_actor_map' => @next_actor_map,
              'rollback_actor' => @rollback_actor,
              'async' => @async,
              'id' => @id,
              'act_name' => @act_name,
              'activities' => activity_class_to_name(@activities),
              'condition' => @condition.to_source
          }
      }.to_json(*args)
    end

    def self.json_create(json_data_hash)
      obj = new
      obj.next_actor_map = json_data_hash['next_actor_map']
      obj.rollback_actor = json_data_hash['rollback_actor']
      obj.async = json_data_hash['async']
      obj.id = json_data_hash['id']
      obj.activities = activity_name_to_class json_data_hash['activities']
      obj.condition = eval(json_data_hash['condition'])
      obj.act_name = json_data_hash['act_name']
      obj
    end

    private
    def activity_class_to_name(activity_class_list)
      activity_class_list.map {|activity_class| activity_class.name}
    end

    private
    def activity_name_to_class(activity_name_list)
      activity_name_list.map {|activity_name| Kernel.const_get(activity_name)}
    end

  end

end

