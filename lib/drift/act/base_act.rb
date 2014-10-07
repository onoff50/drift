module Drift

  #
  # An act is series of actions performed by actors. To perform the act we must know our actions/activities
  # to be performed by the selected/suitable actors.
  #
  class BaseAct
    class << self

      attr_accessor :first_actor, :name, :desc

      def name
        self.name
      end

      def desc
        'Description not available'
      end

      #Depricated
      def register_actors(actors = {})
        actors.each do |k, v|
          add_actor v, k
        end
      end

      def execute(context)
        actor = first_actor
        begin
          actor.action(context)
          actor = actor.next_actor
        end while actor
      end


      def single_actor(activity)
        SingleActor.new(activity)
      end

      def condition_actor(then_activity, else_activity, condition)
        ConditionActor.new(then_activity, else_activity, condition)
      end


      #  todo
      def switch_actor(activities, condition)
        #add_actor
      end

      def to_s
        @actors.to_s
      end


    end
  end

end

