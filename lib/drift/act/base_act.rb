require_relative "../helper/drift_helper"

module Drift

  class BaseAct

    class << self

      include DriftHelper

      attr_accessor :start, :act_metadata

      def execute(context)
        @start.execute context
      end

      #args
      # next actor_id
      # context
      def execute_next(actor_id, context)
        raise DriftException, "No registered actor found" if @act_metadata.nil?
        @act_metadata.actor(actor_id).execute context
      end

      #args
      # actor instance
      def register_actor(actor)
        @act_metadata = ActMetadata.new if @act_metadata.nil?
        @act_metadata.register_actor actor
      end

    end

  end

end
