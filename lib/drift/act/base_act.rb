module Drift

  #
  # An act is series of actions performed by actors. To perform the act we must know our actions/activities
  # to be performed by the selected/suitable actors.
  #
  class BaseAct
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
          v.action(args)
        end
      end

    end
  end

end

