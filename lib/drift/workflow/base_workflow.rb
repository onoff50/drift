module Drift

  class BaseWorkflow

    @@activity_hash = {}
    attr_accessor :context, :name, :desc

    def initialize(name, desc)
      @name = name
      @desc = desc
    end

    def register_activities(args)
      @@activity_hash = args[:activity]
    end

    def self.activity_hash
      @@activity_hash
    end

    def execute(args)
      @context = args[:context] || {}
      trigger_activities
    end

    private
    def trigger_activities



    end

  end

end