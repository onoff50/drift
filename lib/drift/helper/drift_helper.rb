require 'uuidtools'

module Drift
  module DriftHelper

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      # todo exception for sync task defined with queue name
      def single_actor(activity, async = false, queue = nil)
        SingleActor.new(activity, generate_id, async, queue)
      end

      def switch_actor(condition, async = false, queue = nil)
        SwitchActor.new(condition, generate_id, async, queue)
      end

      private
      def generate_id
        UUIDTools::UUID.timestamp_create
      end

    end

  end
end