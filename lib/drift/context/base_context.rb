module Drift

  class BaseContext
    attr_accessor :context

    def initialize(args = {})
      @context = args.clone
    end

    def [](key)
      @context[key]
    end

    def []=(key, value)
      $logger.info "Writing to context KEY = #{key}, VALUE = #{value.inspect}"
      raise DriftException, 'Key can not be nil' if key.nil?
      @context.merge!(key => value) if (key.present?)
    end

    def size
      @context.size
    end

    def to_json(*args)
       @context.to_json(*args)
    end

    def self.json_create args
      new args
    end

  end
end