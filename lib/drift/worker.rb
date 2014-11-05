require_relative '../../lib/drift/message_client'

module Drift

  module Worker

    def self.included(base)
      base.extend(ClassMethods)
      base.class_attribute :queue_name
    end

    module ClassMethods

      def perform_async(context, act_name, actor_id, queue_name = nil)
        client_push(
            {
                'context' => context.to_json,
                'act_name' => act_name,
                'actor_id' => actor_id
            }, queue_name, context['group_id'])
      end

      def get_worker_queue_name
        self.queue_name || Drift.default_worker_options['queue_name']
      end

      def get_app_id
        Drift.default_worker_options['app_id']
      end

      def client_push(payload, queue_name, group_id)
        Drift::MessageClient.new(get_app_id, queue_name || get_worker_queue_name).push(payload, group_id)
      end

    end

  end

end


