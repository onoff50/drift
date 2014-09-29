module Drift

  class BaseWorkflow
    class << self

      attr_accessor :actors, :name, :desc

      def name
        self.name
      end

      def desc
        'Description not available'
      end

      def register_actors(actors = {})
        @actors = actors
      end

      def execute(args)
        Hash[@actors.sort].each do |k, v|
          v.act(args)
        end
      end

    end
  end

end

