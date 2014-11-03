require_relative 'actor_metadata'

module Drift

  class SingleActorMetadata < ActorMetadata

    attr_accessor :activity

    def to_json(*args)
      json_hash = to_json_base_hash
      json_hash['data'].merge!('activity' => @activity)
      json_hash.to_json(*args)
    end

    def self.json_create(json_data_hash)
      obj = json_populate_base_attributes(new, json_data_hash)
      obj.activity = Kernel.const_get(json_data_hash['activity'])
      obj
    end

  end

end

