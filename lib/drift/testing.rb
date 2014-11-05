require_relative '../../lib/drift/worker'

module Drift

  class Testing
    class << self
      attr_accessor :__test_mode

      def __set_test_mode(mode)
        self.__test_mode = mode
      end

      def disable!
        __set_test_mode :disable
      end

      def fake!
        __set_test_mode :fake
      end

      def inline!
        __set_test_mode :inline
      end

      def enabled?
        self.__test_mode != :disable
      end

      def disabled?
        self.__test_mode == :disable
      end

      def fake?
        self.__test_mode == :fake
      end

      def inline?
        self.__test_mode == :inline
      end
    end
  end

  # default testing mode
  Drift::Testing.inline!

  module Worker

    module ClassMethods

      attr_accessor :jobs
      alias_method :client_push_real, :client_push

      def client_push(payload, queue_name, group_id)
        if Drift::Testing.fake?
          jobs = [] if jobs.nil?
          jobs << payload
          true
        elsif Drift::Testing.inline?
          execute_job payload
          true
        else
          client_push_real payload, queue_name, group_id
        end
      end

      def drain_jobs
        unless jobs.nil?
          jobs.each do |job_payload|
            execute_job job_payload
          end
        end
      end

      private
      def execute_job(payload)
        act_class = Kernel.const_get(payload['act_name'])
        context = Drift::BaseContext.json_create payload['context']
        actor = act_class.get_actor payload['actor_id']
        actor.perform context
      end

    end

  end

end
