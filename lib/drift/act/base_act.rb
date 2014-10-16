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
        @act_metadata.actor(actor_id).execute(context)  unless @act_metadata.actor(actor_id).nil?
      end

      #args
      # actor instance list
      def register_actors(*actors)
        @act_metadata = ActMetadata.new if @act_metadata.nil?
        actors.each do |actor|
          @act_metadata.register_actor actor
        end
      end

    end

  end

end
