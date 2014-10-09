require_relative "../helper/drift_helper"

module Drift

  #
  # An act is series of actions performed by actors. To perform the act we must know our actions/activities
  # to be performed by the selected/suitable actors.
  #
  class BaseAct

    class << self

      include DriftHelper

      attr_accessor :first_actor, :desc

      #def name
      #  self.name
      #end

      def desc
        'Description not available'
      end

      def execute(context)
        actor = first_actor
        begin
          actor.action(context)
          actor = actor.next_actor
        end while actor
      end

      def to_s
        "Start #{first_actor.to_s}, name #{@name}, desc #{desc}"
      end


    end
  end

end

