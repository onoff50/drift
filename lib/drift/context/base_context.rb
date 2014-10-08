module Drift

  class BaseContext
    attr_accessor :context

    def initialize(args = {})
      @context = args.clone
    end

    def add(key, value)
      $logger.info "Writing to context KEY = #{key}, VALUE = #{value.inspect}"

      raise DriftException, 'Key can not be nil' if key.blank?
      raise DriftException, 'Key already present' if (@context[key].present?)

      add!(key, value)
    end

    def add!(key, value)
      @context.merge!(key => value) if (key.present?)
    end

    def to_s
      @context.to_s
    end

    def to_json
      @context.to_json
    end

    def [] key
      @context[key]
    end

    def size
      @context.size
    end

  end
end