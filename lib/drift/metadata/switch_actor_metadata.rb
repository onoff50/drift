require_relative 'actor_metadata'

module Drift

  class SwitchActorMetadata < ActorMetadata

    attr_accessor :condition

    def to_json(*args)
      json_hash = to_json_base_hash
      json_hash['data'].merge!('condition' => @condition)
      json_hash.to_json(*args)
    end

    def self.json_create(json_data_hash)
      obj = json_populate_base_attributes(new, json_data_hash)
      obj.condition = Kernel.const_get(json_data_hash['condition'])
      obj
    end

  end

end

