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

      def desc
        "First actor #{@first_actor.name},  Description not Available"
      end

      def execute(context)
        @first_actor.perform context
      end


    end
  end

end

