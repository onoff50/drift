module Drift

  class ConditionalActorMetadata < ActorMetadata

    attr_accessor :then_activity, :else_activity, :condition

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
              'act' => @act,
              'then_activity' => @then_activity.name,
              'else_activity' => @else_activity.name,
              'condition' => @condition.to_source
          }
      }.to_json(*args)
    end

    def self.json_create(json_data_hash)
      obj = new()
      obj.next_actor_map = json_data_hash['next_actor_map']
      obj.async = json_data_hash['async']
      obj.id = json_data_hash['id']
      obj.then_activity = Kernel.const_get(json_data_hash['then_activity'])
      obj.else_activity = Kernel.const_get(json_data_hash['else_activity'])
      obj.condition = eval(json_data_hash['condition'])
      obj.act = Kernel.const_get(json_data_hash['act'])
      obj
    end

  end

end
