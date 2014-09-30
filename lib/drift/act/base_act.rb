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

      #Depricated
      def register_actors(actors = {})
        actors.each do |k, v|
          add_actor v, k
        end
      end

      def execute(context)
        @actors.each do |k, v|
          v.action(context)
        end
      end


      def register_single_actor(activity)
        add_actor SingleActor.new(activity)

      end

      def register_condition_actor(then_activity, else_activity, condition)
        add_actor ConditionActor.new(then_activity, else_activity, condition)
      end

      #  todo
      def register_switch_actor(activities, condition)
        #add_actor
      end

      def to_s
        @actors.to_s
      end

      def print
        @actors.each do |entry|
          $logger.info entry.to_s + "\n"
        end
      end


      private
      #todo: we may not need sort as order is guaranteed
      def get_key
        (@actors.keys.sort.last.to_i + 1)
      end

      def add_actor(actor, key = nil)
        @actors = ActiveSupport::OrderedHash.new if @actors.nil?
        key = get_key if key.nil?
        @actors[key] = actor
      end


    end
  end

end

