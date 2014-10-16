require_relative "../helper/drift_helper"

module Drift

  class BaseAct

    class << self

      include DriftHelper

      attr_accessor :start, :act_metadata
      @start = nil
      @act_metadata = ActMetadata.new

      def execute(context)
        @start.execute context
      end

      #args
      # next actor_id
      # context
      def execute_next(actor_id, context)
        @act_metadata.actor(actor_id).execute context
      end

      #args
      # actor instance
      def register_actor(actor)
        @act_metadata.register_actor actor
      end

    end

  end

end
