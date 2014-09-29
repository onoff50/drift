module Drift


  class BaseContext
    attr_accessor :context

    def initialize(args = {})
      @context = args
    end

    def add(key, value)
      raise "Key/Value is nil" if (key.blank? || value.blank?)
      raise "Key already present" if (@context[key].present?)

      add!(key, value)
    end

    def add!(key, value)
      @context.merge!(key => value) if (key.present? && value.present?)
    end


  end
end